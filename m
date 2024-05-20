Return-Path: <linux-fsdevel+bounces-19757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75B8C99C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 10:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF28B20EA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DDE1BF38;
	Mon, 20 May 2024 08:23:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071FB1BC23
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193389; cv=none; b=Zd6haQRvnYDjKHQm7Q4Ig2mmKpt7Cny0mHkX5MyxTjGQ3Vd9fnUyTzRNHAfl7U1Eqq4rG/7dnLXijwVV84tewKB0GrmNTvEkgK1eICxmT9OkoIfsX6A4YpigofPMHQvVAJycn09LvQwoX3f5OqtMcoHkSEL38uyio307OVsjMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193389; c=relaxed/simple;
	bh=7eH1ldMVrB8oQOfksQfqWP8QXDBW1CGqxG2ByyYKJsE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Wnkh6M9A0BW/1JD0TSGYB08sr8/7gculkQ31Ua+qTgk2NdX4nrDqenKIliOrHOYvKENsPljmg6dfjk4go1PIaUGF8VhZDxPLv1POkHml+60hEn1Lc+5q4BUtyKNXiQ2+GuK0LWvjN8CL0WdgFm4zt6REqifSKgvAf4fgb9K7/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-574d1a1c36aso6910017a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 01:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716193386; x=1716798186;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8YP0ihyz/Bv+vlTSvHrMPOw4n8dHfLUnUHpZN/S6AQ=;
        b=E9Kxng5GIweS9XoyXj6dG2Pn7JooL96oJe6lt8TfXOnGNIU44ZCe9THVlKjxTp2X/n
         zq0IgoyPDyMNWRfU3MMr3i00RAr/tArCRSImNLbW3S82j5GxHE/KdU6kn0PXsg67JWwH
         nmG/FVgi7xgOCwVTEIyWx1pNYFg5ygufRILmVx93tFb3M5SK8kALVoIemauLTP+/dLQO
         0SubLwAJ3jgR47+1PqrFGIm0A5twH7dxncwHHET8NBXmAZ9NgWChowgMBDGShisUfLU+
         xaYkR5CpjUTcOS0MuTWbpoCGTD4LsjTyZK8H4SfKzv0O9Oy9r5iMvYQm1sDVfFbBMtjh
         L4LA==
X-Forwarded-Encrypted: i=1; AJvYcCViau593sRexNdFBJ+rI7pp2WGTtHhK/N6qC7sVNS6YmjF+wugWbILPwteLjnuxl2ARKNvTKpiTKvrnYnAWCQNGDxzoeiys9iNAVljzAQ==
X-Gm-Message-State: AOJu0YxX45YWF7WAOPu+srCSy0Wef1oKQ7hPRQp/MgYFdKzB81b6VD/S
	f9WG96mnZQGVcNAsTwUlDsixbVyCDlg1rbLVhndamAwrX1OnFVzAMbLCBw==
X-Google-Smtp-Source: AGHT+IHOQvmtLbJloFE29fNKUB6lRQPLzIYF0ovwaEieKO+h8c3uMXc1LlskTJK8jNs1fLOnm+ll0g==
X-Received: by 2002:a17:907:72c5:b0:a60:46a9:7d60 with SMTP id a640c23a62f3a-a6046a97fdemr253165766b.28.1716193386260;
        Mon, 20 May 2024 01:23:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c6b1sm1432746766b.57.2024.05.20.01.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 01:23:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ZKcZffmvm7EHGWoB1bGW6sc9"
Message-ID: <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org>
Date: Mon, 20 May 2024 10:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee
 <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>
 <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner>
 <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org>
 <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>

This is a multi-part message in MIME format.
--------------ZKcZffmvm7EHGWoB1bGW6sc9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17. 05. 24, 22:07, Linus Torvalds wrote:
> On Fri, 17 May 2024 at 00:54, Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>>           inode->i_private = data;
>>           inode->i_flags |= S_PRIVATE;
>> +       inode->i_mode &= ~S_IFREG;
> 
> That is not a sensible operation. S_IFREG isn't a bit mask.

Oh, sure. I just unmasked what libfs' prepare_anon_dentry() set by default.

> But it looks like 'anon_inode' traditionally had *no* type bytes at
> all. That's literally crazy.
> 
> Doing a 'stat -L' on one in /proc/X/fd/Y will correctly say "weird
> file" about them.
> 
> What a crock. That's horrible, and we apparently never noticed how
> broken anon_inodes were because nobody really cared. But then lsof
> seems to have done the *opposite* and just said (for unfathomable
> reasons) "this can't be a normal regular file".
> 
> But I can't actually find that code in lsof. I see
> 
>                   if (rest && rest[0] == '[' && rest[1] == 'p')
>                       fdinfo_mask |= FDINFO_PID;
> 
> which only checks that the name starts with '[p'. Hmm.

lsof just has received a fix in a form of:
    else if (Lf->ntype == N_REGLR && rest && *rest && strcmp(pbuf, 
"pidfd") == 0) {

https://github.com/lsof-org/lsof/pull/319/commits/c1678e3f6e4b4d984cb3078b7bf0c9e24bedb8ca

> [ Time passes, I go looking ]
> 
> Oh Christ. It's process_proc_node:

Yes, didn't I note it? Hmm, apparently not (or maybe it's hidden in all 
those pulls/isuses/bugs). But definitely been there, seen that. Sorry.

>          type = s->st_mode & S_IFMT;
>          switch (type) {
>          ...
>          case 0:
>              if (!strcmp(p, "anon_inode"))
>                  Lf->ntype = Ntype = N_ANON_INODE;
>              break;
> 
> so yes, process_proc_node() really seems to have intentionally noticed
> that our anon inodes forgot to put a file type in the st_mode, and
> together with the path from readlink matching 'anon_inode' is how lsof
> determines it's one of the special inodes.
> 
> So yeah, we made a mistake, and then lsof decided that mistake was a feature.

Yes, but we can schedule a removal of this compat handling after some 
years...

> But that does mean that we probably just have to live in the bed we made.
> 
> But that
> 
>> +       inode->i_mode &= ~S_IFREG;
> 
> is still very very wrong. It should use the proper bit mask: S_IFMT.

Either, I don't like removing that WARN_ON_ONCE() from libfs' 
prepare_anon_dentry(). Is it OK to remove this S_IFREG after 
path_from_stashed() in pidfs' pidfs_alloc_file(). I.e. after 
d_alloc_anon(), d_instantiate(), stash_dentry(), but before dentry_open()?

That looks weird.

Instead, add a sort of LEGACY_DONT_WARN_ABOUT_IFMT to path_from_stashed()?

Dirty, I think.

So what about LEGACY_NO_MODE which would set "i_mode = 0" and mangle the 
WARN_ON appropriately. Like in the patch attached? It works (when 
applied together with the anon_inode name fix).

> And we'd have to add a big comment about our historical stupidity that
> we are perpetuating.

And immediately add it to Documentation/ABI/obsolete/?

thanks,
-- 
js
suse labs

--------------ZKcZffmvm7EHGWoB1bGW6sc9
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-add-LEGACY_NO_MODE.patch"
Content-Disposition: attachment; filename="0001-add-LEGACY_NO_MODE.patch"
Content-Transfer-Encoding: base64

RnJvbSBiMDA1Y2Q5NmM5NzY4NGFkZmFiZjA3YzU2YmQ5MWZhYmU0NWM4Y2I3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiSmlyaSBTbGFieSAoU1VTRSkiIDxqaXJpc2xhYnlA
a2VybmVsLm9yZz4KRGF0ZTogTW9uLCAyMCBNYXkgMjAyNCAxMDoxMzo0NCArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIGFkZCBMRUdBQ1lfTk9fTU9ERQoKU2lnbmVkLW9mZi1ieTogSmlyaSBT
bGFieSAoU1VTRSkgPGppcmlzbGFieUBrZXJuZWwub3JnPgotLS0KIERvY3VtZW50YXRpb24v
QUJJL29ic29sZXRlL2xpYmZzLUxFR0FDWV9OT19NT0RFIHwgIDggKysrKysrKysKIGZzL2lu
dGVybmFsLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysrKy0K
IGZzL2xpYmZzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTEg
KysrKysrLS0tLS0KIGZzL25zZnMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDQgKystLQogZnMvcGlkZnMuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyArKy0KIDUgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL0FC
SS9vYnNvbGV0ZS9saWJmcy1MRUdBQ1lfTk9fTU9ERQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vQUJJL29ic29sZXRlL2xpYmZzLUxFR0FDWV9OT19NT0RFIGIvRG9jdW1lbnRhdGlv
bi9BQkkvb2Jzb2xldGUvbGliZnMtTEVHQUNZX05PX01PREUKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMDAwLi4zN2FkMDM2YjE4YjIKLS0tIC9kZXYvbnVsbAorKysg
Yi9Eb2N1bWVudGF0aW9uL0FCSS9vYnNvbGV0ZS9saWJmcy1MRUdBQ1lfTk9fTU9ERQpAQCAt
MCwwICsxLDggQEAKK1doYXQ6CQlsaWJmcycgTEVHQUNZX05PX01PREUKK0RhdGU6CQlNYXkg
MjAyNAorS2VybmVsVmVyc2lvbjoJNi4xMAorQ29udGFjdDoJbGludXgtZnNkZXZlbEB2Z2Vy
Lmtlcm5lbC5vcmcKK0Rlc2NyaXB0aW9uOglMRUdBQ1lfTk9fTU9ERSB3YXMgYWRkZWQgdG8g
bWltaWMgdGhlIG9sZCAod3JvbmcpIGlfbW9kZSAoemVybykKKwkJb2YgYW5vbl9pbm9kZSB3
aGVuIHBpZGZzIHdhcyBtb3ZlZCBhd2F5IGZyb20gYW5vbl9pbm9kZSB0bworCQlsaWJmcyBo
ZWxwZXJzLgorVXNlcnM6CQlsc29mCmRpZmYgLS1naXQgYS9mcy9pbnRlcm5hbC5oIGIvZnMv
aW50ZXJuYWwuaAppbmRleCA3Y2E3Mzg5MDRlMzQuLmE3Y2QwZWVjYzI2NiAxMDA2NDQKLS0t
IGEvZnMvaW50ZXJuYWwuaAorKysgYi9mcy9pbnRlcm5hbC5oCkBAIC0zMTUsNiArMzE1LDkg
QEAgc3RydWN0IHN0YXNoZWRfb3BlcmF0aW9ucyB7CiAJdm9pZCAoKnB1dF9kYXRhKSh2b2lk
ICpkYXRhKTsKIAlpbnQgKCppbml0X2lub2RlKShzdHJ1Y3QgaW5vZGUgKmlub2RlLCB2b2lk
ICpkYXRhKTsKIH07CisKKyNkZWZpbmUgTEVHQUNZX05PX01PREUJCUJJVCgwKQorCiBpbnQg
cGF0aF9mcm9tX3N0YXNoZWQoc3RydWN0IGRlbnRyeSAqKnN0YXNoZWQsIHN0cnVjdCB2ZnNt
b3VudCAqbW50LCB2b2lkICpkYXRhLAotCQkgICAgICBzdHJ1Y3QgcGF0aCAqcGF0aCk7CisJ
CSAgICAgIHN0cnVjdCBwYXRoICpwYXRoLCB1bnNpZ25lZCBpbnQgZmxhZ3MpOwogdm9pZCBz
dGFzaGVkX2RlbnRyeV9wcnVuZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpOwpkaWZmIC0tZ2l0
IGEvZnMvbGliZnMuYyBiL2ZzL2xpYmZzLmMKaW5kZXggYjYzNWVlNWFkYmNjLi5jMDQ3YWE0
ZjRkYWMgMTAwNjQ0Ci0tLSBhL2ZzL2xpYmZzLmMKKysrIGIvZnMvbGliZnMuYwpAQCAtMjA0
NSwxMSArMjA0NSwxMiBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBkZW50cnkgKmdldF9zdGFz
aGVkX2RlbnRyeShzdHJ1Y3QgZGVudHJ5ICpzdGFzaGVkKQogCiBzdGF0aWMgc3RydWN0IGRl
bnRyeSAqcHJlcGFyZV9hbm9uX2RlbnRyeShzdHJ1Y3QgZGVudHJ5ICoqc3Rhc2hlZCwKIAkJ
CQkJICBzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLAotCQkJCQkgIHZvaWQgKmRhdGEpCisJCQkJ
CSAgdm9pZCAqZGF0YSwgdW5zaWduZWQgaW50IGZsYWdzKQogewogCXN0cnVjdCBkZW50cnkg
KmRlbnRyeTsKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlOwogCWNvbnN0IHN0cnVjdCBzdGFzaGVk
X29wZXJhdGlvbnMgKnNvcHMgPSBzYi0+c19mc19pbmZvOworCXVtb2RlX3QgaV9tb2RlOwog
CWludCByZXQ7CiAKIAlpbm9kZSA9IG5ld19pbm9kZV9wc2V1ZG8oc2IpOwpAQCAtMjA1OSw3
ICsyMDYwLDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKnByZXBhcmVfYW5vbl9kZW50cnko
c3RydWN0IGRlbnRyeSAqKnN0YXNoZWQsCiAJfQogCiAJaW5vZGUtPmlfZmxhZ3MgfD0gU19J
TU1VVEFCTEU7Ci0JaW5vZGUtPmlfbW9kZSA9IFNfSUZSRUc7CisJaW5vZGUtPmlfbW9kZSA9
IGlfbW9kZSA9IChmbGFncyAmIExFR0FDWV9OT19NT0RFKSA/IDAgOiBTX0lGUkVHOwogCXNp
bXBsZV9pbm9kZV9pbml0X3RzKGlub2RlKTsKIAogCXJldCA9IHNvcHMtPmluaXRfaW5vZGUo
aW5vZGUsIGRhdGEpOwpAQCAtMjA2OSw3ICsyMDcwLDcgQEAgc3RhdGljIHN0cnVjdCBkZW50
cnkgKnByZXBhcmVfYW5vbl9kZW50cnkoc3RydWN0IGRlbnRyeSAqKnN0YXNoZWQsCiAJfQog
CiAJLyogTm90aWNlIHdoZW4gdGhpcyBpcyBjaGFuZ2VkLiAqLwotCVdBUk5fT05fT05DRSgh
U19JU1JFRyhpbm9kZS0+aV9tb2RlKSk7CisJV0FSTl9PTl9PTkNFKChpbm9kZS0+aV9tb2Rl
ICYgU19JRk1UKSAhPSBpX21vZGUpOwogCVdBUk5fT05fT05DRSghSVNfSU1NVVRBQkxFKGlu
b2RlKSk7CiAKIAlkZW50cnkgPSBkX2FsbG9jX2Fub24oc2IpOwpAQCAtMjEyNiw3ICsyMTI3
LDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKnN0YXNoX2RlbnRyeShzdHJ1Y3QgZGVudHJ5
ICoqc3Rhc2hlZCwKICAqIFJldHVybjogT24gc3VjY2VzcyB6ZXJvIGFuZCBvbiBmYWlsdXJl
IGEgbmVnYXRpdmUgZXJyb3IgaXMgcmV0dXJuZWQuCiAgKi8KIGludCBwYXRoX2Zyb21fc3Rh
c2hlZChzdHJ1Y3QgZGVudHJ5ICoqc3Rhc2hlZCwgc3RydWN0IHZmc21vdW50ICptbnQsIHZv
aWQgKmRhdGEsCi0JCSAgICAgIHN0cnVjdCBwYXRoICpwYXRoKQorCQkgICAgICBzdHJ1Y3Qg
cGF0aCAqcGF0aCwgdW5zaWduZWQgaW50IGZsYWdzKQogewogCXN0cnVjdCBkZW50cnkgKmRl
bnRyeTsKIAljb25zdCBzdHJ1Y3Qgc3Rhc2hlZF9vcGVyYXRpb25zICpzb3BzID0gbW50LT5t
bnRfc2ItPnNfZnNfaW5mbzsKQEAgLTIxMzksNyArMjE0MCw3IEBAIGludCBwYXRoX2Zyb21f
c3Rhc2hlZChzdHJ1Y3QgZGVudHJ5ICoqc3Rhc2hlZCwgc3RydWN0IHZmc21vdW50ICptbnQs
IHZvaWQgKmRhdGEsCiAJfQogCiAJLyogQWxsb2NhdGUgYSBuZXcgZGVudHJ5LiAqLwotCWRl
bnRyeSA9IHByZXBhcmVfYW5vbl9kZW50cnkoc3Rhc2hlZCwgbW50LT5tbnRfc2IsIGRhdGEp
OworCWRlbnRyeSA9IHByZXBhcmVfYW5vbl9kZW50cnkoc3Rhc2hlZCwgbW50LT5tbnRfc2Is
IGRhdGEsIGZsYWdzKTsKIAlpZiAoSVNfRVJSKGRlbnRyeSkpCiAJCXJldHVybiBQVFJfRVJS
KGRlbnRyeSk7CiAKZGlmZiAtLWdpdCBhL2ZzL25zZnMuYyBiL2ZzL25zZnMuYwppbmRleCAw
N2UyMmExNWVmMDIuLjExYjhlZjJhZWFlZCAxMDA2NDQKLS0tIGEvZnMvbnNmcy5jCisrKyBi
L2ZzL25zZnMuYwpAQCAtNTYsNyArNTYsNyBAQCBpbnQgbnNfZ2V0X3BhdGhfY2Ioc3RydWN0
IHBhdGggKnBhdGgsIG5zX2dldF9wYXRoX2hlbHBlcl90ICpuc19nZXRfY2IsCiAJaWYgKCFu
cykKIAkJcmV0dXJuIC1FTk9FTlQ7CiAKLQlyZXR1cm4gcGF0aF9mcm9tX3N0YXNoZWQoJm5z
LT5zdGFzaGVkLCBuc2ZzX21udCwgbnMsIHBhdGgpOworCXJldHVybiBwYXRoX2Zyb21fc3Rh
c2hlZCgmbnMtPnN0YXNoZWQsIG5zZnNfbW50LCBucywgcGF0aCwgMCk7CiB9CiAKIHN0cnVj
dCBuc19nZXRfcGF0aF90YXNrX2FyZ3MgewpAQCAtMTAxLDcgKzEwMSw3IEBAIGludCBvcGVu
X3JlbGF0ZWRfbnMoc3RydWN0IG5zX2NvbW1vbiAqbnMsCiAJCXJldHVybiBQVFJfRVJSKHJl
bGF0aXZlKTsKIAl9CiAKLQllcnIgPSBwYXRoX2Zyb21fc3Rhc2hlZCgmcmVsYXRpdmUtPnN0
YXNoZWQsIG5zZnNfbW50LCByZWxhdGl2ZSwgJnBhdGgpOworCWVyciA9IHBhdGhfZnJvbV9z
dGFzaGVkKCZyZWxhdGl2ZS0+c3Rhc2hlZCwgbnNmc19tbnQsIHJlbGF0aXZlLCAmcGF0aCwg
MCk7CiAJaWYgKGVyciA8IDApIHsKIAkJcHV0X3VudXNlZF9mZChmZCk7CiAJCXJldHVybiBl
cnI7CmRpZmYgLS1naXQgYS9mcy9waWRmcy5jIGIvZnMvcGlkZnMuYwppbmRleCBhNjNkNWQy
NGFhMDIuLmNiODk0ZTkwMjRlZCAxMDA2NDQKLS0tIGEvZnMvcGlkZnMuYworKysgYi9mcy9w
aWRmcy5jCkBAIC0yNjYsNyArMjY2LDggQEAgc3RydWN0IGZpbGUgKnBpZGZzX2FsbG9jX2Zp
bGUoc3RydWN0IHBpZCAqcGlkLCB1bnNpZ25lZCBpbnQgZmxhZ3MpCiAJc3RydWN0IHBhdGgg
cGF0aDsKIAlpbnQgcmV0OwogCi0JcmV0ID0gcGF0aF9mcm9tX3N0YXNoZWQoJnBpZC0+c3Rh
c2hlZCwgcGlkZnNfbW50LCBnZXRfcGlkKHBpZCksICZwYXRoKTsKKwlyZXQgPSBwYXRoX2Zy
b21fc3Rhc2hlZCgmcGlkLT5zdGFzaGVkLCBwaWRmc19tbnQsIGdldF9waWQocGlkKSwgJnBh
dGgsCisJCQkJTEVHQUNZX05PX01PREUpOwogCWlmIChyZXQgPCAwKQogCQlyZXR1cm4gRVJS
X1BUUihyZXQpOwogCi0tIAoyLjQ1LjEKCg==

--------------ZKcZffmvm7EHGWoB1bGW6sc9--

