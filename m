Return-Path: <linux-fsdevel+bounces-7998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10882E0D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD67A1C21A2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2F18C15;
	Mon, 15 Jan 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDiD8nFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81717BD5
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-206ebe78593so1270767fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 11:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705347776; x=1705952576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=slrRXzAVFZAUbv+A5SksSDfk0sNSvKd+rJ5CcYu2NxA=;
        b=XDiD8nFoVKTlsoAaaofvvfnCUfaeku7+6n2pwQlAFkFPmiQr7nG/ZvO/BaqX9rpDsT
         f27rtrjbSOkvkiin5pm6+iJXLMwPxX1+Y1/G5otsEt8gWs+wc8PrMCGOTaoD59wXv3i3
         u252k+IGm5dfj4frL0sMSkrBI2aUeW26/xGka7xxYI5S/MBelNhX+J2yFmHIy2QGh3Ws
         u4ZnlwEIDdZ4sI5Lem9hQ8L5Z/byqc+ILzNyzNvJUyNNMgAzac+2yUHX4k964Vc67zor
         QPhHgHhOg07yBAnyJHml/ES29Ka+KcW2i40wnAB5MEuBYTCYEbrXmJqVazhoKDQefE/v
         bsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705347776; x=1705952576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slrRXzAVFZAUbv+A5SksSDfk0sNSvKd+rJ5CcYu2NxA=;
        b=IKSCK1lFu87XN/nmehfFQ8Z+gcNWMdFidqXOyz1VSZE2wJL+woiV3HAhz5XRYdV4B8
         /Xk5SSmZiztV0WZpW6FORVSyEzqeSznMpKxMtigvMWFyeVd1urEsT7wMTSRTorHRZJX1
         yhGbo+7mtSGKlWMukANeAlmGSgpPrZZxmR1gZBxpR7z013E41rmioCvci5viHMdaHxrJ
         +CHPGwtMlJBvqhUbb0Pa+cnRjem1LsXpGVqsiPXFbjh8piBlhKsBG8pT227BqnOmeor1
         yj8PQLnENU3u5lsYEw5BfEQpUZ61QCqmSI9GJV2/8auGF1+6FjITaBaHBNXp+3wIKBp/
         3grQ==
X-Gm-Message-State: AOJu0YxrTM/fFoM3sna/QwiT5gg8J2nS134Vs3w7HJLSnq/ht9NcCxM3
	R7HJxeJfqKajVyOvnK9iekgFttZOSMw+RHN2Gtb4tb0sJxw=
X-Google-Smtp-Source: AGHT+IFJYrnCvLusjSW8+QMhz4f4tI2q+9tPP2LaXxrkkHht/PriD804AuPDFxRms5dke5aHcRavd2v9YNNPbG5vESw=
X-Received: by 2002:a05:6870:8a13:b0:207:559:1a3d with SMTP id
 p19-20020a0568708a1300b0020705591a3dmr3057408oaq.110.1705347775790; Mon, 15
 Jan 2024 11:42:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111152233.352912-1-amir73il@gmail.com> <20240112110936.ibz4s42x75mjzhlv@quack3>
 <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
 <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk> <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
 <CAOQ4uxgzvz9XE4eMLaRt4Jkg-o4+mTQvgbHrayx27ku2ONGfPg@mail.gmail.com> <20240115183758.6yq6wjqjvhreyqnu@quack3>
In-Reply-To: <20240115183758.6yq6wjqjvhreyqnu@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Jan 2024 21:42:44 +0200
Message-ID: <CAOQ4uxhLum65Nou=DRaAT6W5xTvWjjP4+5mxYv2K3j4PB89s1A@mail.gmail.com>
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event watchers
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000065806c060f0138a9"

--00000000000065806c060f0138a9
Content-Type: text/plain; charset="UTF-8"

> > So at this time, we have patch v2 which looks like a clear win.
> > It uses a slightly hackish SB_I_CONTENT_WATCHED to work around
> > the fact that real_mount() is not accessible to the inlined call sites.
>
> But won't it be better to move mnt_fsnotify_mask and perhaps
> mnt_fsnotify_marks (to keep things in one place) into struct vfsmount in
> that case?

I am afraid to even bring this up to Al and Christian ;-)

> IMHO working around this visibility problem with extra flag (and
> the code maintaining it) is not a great tradeoff...

I agree.

>
> As I wrote in my email to Jens I think your v3 patch just makes the real
> cost of fsnotify checks visible in fsnotify_path() instead of being hidden
> in the cost of read / write.

There is a flaw in that argument -
Assuming that in Jens' test no parent/mnt/sb are watching,
all the reads/write on regular file would end up calling __fsnotify_parent()
in upstream code - there is nothing to optimize away this call.

But now that I am looking closer at __fsnotify_parent(), I see what you
were trying to say - if I move the checks from fsnotify_path() to the
beginning of __fsnotify_parent(), it should get most of the performance
from v3 patch, so this is all that should be needed is this simple patch
attached.

I cannot really understand why we did not do this sooner...

Jens, if you have time for another round please test.
My expectation would be to see something like

+1.46%  [kernel.vmlinux]  [k] __fsnotify_parent

Thanks,
Amir.

+
+               if (!(mask & marks_mask))
+                       return 0;
+       }

--00000000000065806c060f0138a9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fsnotify-optimize-the-case-of-no-parent-watcher.patch"
Content-Disposition: attachment; 
	filename="0001-fsnotify-optimize-the-case-of-no-parent-watcher.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lrfbykuq0>
X-Attachment-Id: f_lrfbykuq0

RnJvbSA0M2JiZWZmNjAxZWQ1MTA5MzZhYzUxYjU3MmQyNDM4ODEwN2YwMzNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDkgRGVjIDIwMjIgMTE6NTA6MjYgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmc25v
dGlmeTogb3B0aW1pemUgdGhlIGNhc2Ugb2Ygbm8gcGFyZW50IHdhdGNoZXIKCklmIHBhcmVudCBp
bm9kZSBpcyBub3Qgd2F0Y2hpbmcsIGNoZWNrIGZvciB0aGUgZXZlbnQgaW4gbWFza3Mgb2YKc2Iv
bW91bnQvaW5vZGUgbWFza3MgZWFybHkgdG8gb3B0aW1pemUgb3V0IG1vc3Qgb2YgdGhlIGNvZGUg
aW4KX19mc25vdGlmeV9wYXJlbnQoKSBhbmQgZnNub3RpZnkoKS4KClNpZ25lZC1vZmYtYnk6IEFt
aXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvbm90aWZ5L2Zzbm90aWZ5
LmMgfCAxNiArKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9mc25vdGlmeS5jIGIvZnMv
bm90aWZ5L2Zzbm90aWZ5LmMKaW5kZXggOGJmZDY5MGU5ZjEwLi5hZTc0ZjZlNjBjNjQgMTAwNjQ0
Ci0tLSBhL2ZzL25vdGlmeS9mc25vdGlmeS5jCisrKyBiL2ZzL25vdGlmeS9mc25vdGlmeS5jCkBA
IC0xOTAsMTMgKzE5MCwxNSBAQCBpbnQgX19mc25vdGlmeV9wYXJlbnQoc3RydWN0IGRlbnRyeSAq
ZGVudHJ5LCBfX3UzMiBtYXNrLCBjb25zdCB2b2lkICpkYXRhLAogCXN0cnVjdCBxc3RyICpmaWxl
X25hbWUgPSBOVUxMOwogCWludCByZXQgPSAwOwogCi0JLyoKLQkgKiBEbyBpbm9kZS9zYi9tb3Vu
dCBjYXJlIGFib3V0IHBhcmVudCBhbmQgbmFtZSBpbmZvIG9uIG5vbi1kaXI/Ci0JICogRG8gdGhl
eSBjYXJlIGFib3V0IGFueSBldmVudCBhdCBhbGw/Ci0JICovCi0JaWYgKCFpbm9kZS0+aV9mc25v
dGlmeV9tYXJrcyAmJiAhaW5vZGUtPmlfc2ItPnNfZnNub3RpZnlfbWFya3MgJiYKLQkgICAgKCFt
bnQgfHwgIW1udC0+bW50X2Zzbm90aWZ5X21hcmtzKSAmJiAhcGFyZW50X3dhdGNoZWQpCi0JCXJl
dHVybiAwOworCS8qIE9wdGltaXplIHRoZSBsaWtlbHkgY2FzZSBvZiBwYXJlbnQgbm90IHdhdGNo
aW5nICovCisJaWYgKGxpa2VseSghcGFyZW50X3dhdGNoZWQpKSB7CisJCV9fdTMyIG1hcmtzX21h
c2sgPSBpbm9kZS0+aV9mc25vdGlmeV9tYXNrIHwKKwkJCQkgICBpbm9kZS0+aV9zYi0+c19mc25v
dGlmeV9tYXNrIHwKKwkJCQkgICAobW50ID8gbW50LT5tbnRfZnNub3RpZnlfbWFzayA6IDApOwor
CisJCWlmICghKG1hc2sgJiBtYXJrc19tYXNrKSkKKwkJCXJldHVybiAwOworCX0KIAogCXBhcmVu
dCA9IE5VTEw7CiAJcGFyZW50X25lZWRlZCA9IGZzbm90aWZ5X2V2ZW50X25lZWRzX3BhcmVudChp
bm9kZSwgbW50LCBtYXNrKTsKLS0gCjIuMzQuMQoK
--00000000000065806c060f0138a9--

