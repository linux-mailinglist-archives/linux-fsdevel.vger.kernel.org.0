Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29AD7EB27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfHBERe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 00:17:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33739 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbfHBERe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:17:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so57651ljg.0;
        Thu, 01 Aug 2019 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HOvSoEEyfCl7/x5I1JZTYO9Hs0zY3XihBGSCCeM/KWA=;
        b=Sn9OgyEwtd1KlJ8Cn2Kvaoug5ShLB8vNk7XVRkJA9i7Fyr9IdwAA3L1Zgk7/ywlP+P
         /rMF0vY57u1zxXtZJjXA+z6bWM1mSK8a7xIi9Q7N+IYQ+vOdtPdpGTeFsBJHh5zGCYvr
         utAcfjKq6zN5+vdh3XFS1iPmVa1ZVQXcMs0Aw+x2UWOHbWTDeAUAkgn6cVQ4FEfso2gL
         hoaZK0uKlKBoWEyTZBGJAzmjN7QMDUAfVZeUS/kdvD44dqGWFQ0WCNS7/4lxzcY+vpau
         Zp/Hn9xx+/ZlwuVPTj9+J942EdJ5AJX4aQ9s9XMUL7nRntbIWP7UE2r5QfEB0x0Ji+kQ
         ycyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HOvSoEEyfCl7/x5I1JZTYO9Hs0zY3XihBGSCCeM/KWA=;
        b=M1h3DwSNAxa+1EQoomN0stdEkGaMdtXDb/ffz5y77MDMM7rNHpRDv4H/k8luNdpqSm
         tV09FOJ6HnJvk4/t0aR4ZwGLhIiq/39EmEQUdUeuL5y4nE70mQEnReDUNhPpgHqFlBxK
         ZqUlWLtqeHlx5IWDfx+htwb8PF1uUhXMHAIo+eb3UVdoElXrGk63R0+SRmDR55G+YM3i
         ppz9LzlQF3g8jYlId8FedwhqhoSSX0MdPxMe7MnTw5Hz3D+yplc0qMCSUh9Noav/RpeZ
         pGj/Zz//eufxlS4X/0Oa4Dd7H8IFmtum7T8KhxU9wSOQuG9uBam2ofiCMr3Lnx7G1fVQ
         ULZA==
X-Gm-Message-State: APjAAAWbAcKmGOupDgF7oKzEwfTH7TQWpRT6tqBVF0CgWIjXI3omV4vc
        dg81IKq6/jJhWr7oIgriWK71RNI4L3cP8c6Fl3I=
X-Google-Smtp-Source: APXvYqwetgzlQupya9GxhfsPelN+cDfVRLEA0BaIXILs9Yttryy1k0k6TbsVhwkN0EBk8YrwRgtXzPzrXMi7t4lbM3w=
X-Received: by 2002:a2e:b60f:: with SMTP id r15mr69665450ljn.172.1564719451610;
 Thu, 01 Aug 2019 21:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <54a35258-081a-71cc-ef1b-9fffcf5e7f9f@nchc.org.tw>
 <CAB3wodfF=Gc3FbKedU4JBWi8hZLxcBPUtVPipsCVnaHdFXGk8Q@mail.gmail.com> <CAKjSHr0vTK6En1_n6GwArV0N6=kM=Czbx2SYat9vK71HuyzMAA@mail.gmail.com>
In-Reply-To: <CAKjSHr0vTK6En1_n6GwArV0N6=kM=Czbx2SYat9vK71HuyzMAA@mail.gmail.com>
From:   Phillip Lougher <phillip.lougher@gmail.com>
Date:   Fri, 2 Aug 2019 05:17:20 +0100
Message-ID: <CAB3wodfgHXN7LPojxS+PV6sDieTi2iQG-YUFU6HAmh=ObY45BA@mail.gmail.com>
Subject: Re: Bug#921146: Program mksquashfs from squashfs-tools 1:4.3-11 does
 not make use all CPU cores
To:     =?UTF-8?B?TMOhc3psw7MgQsO2c3rDtnJtw6lueWkgKEdDUyk=?= 
        <gcs@debian.org>
Cc:     921146@bugs.debian.org, Chris Lamb <lamby@debian.org>,
        hartmans@debian.org, debian-ctte@lists.debian.org,
        Alexander Couzens <lynxis@fe80.eu>,
        linux-fsdevel@vger.kernel.org,
        linux-embedded <linux-embedded@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 1, 2019 at 11:41 PM L=C3=A1szl=C3=B3 B=C3=B6sz=C3=B6rm=C3=A9nyi=
 (GCS) <gcs@debian.org> wrote:

>  Let me add Chris Lamb then the previous Debian Project Leader (also
> British just like you [as I know] and you may sit down and talk about
> this in person) who asked for the reproducibility patch / build in the
> first place.
>

If Chris Lamb or anyone else wants a face-to-face meeting I'm more
than happy to do so.

I coincidentally have a week's holiday (vacation) next week, and I'm
happy to spend a day of it travelling and meeting to discuss the
situation.

I do want to de-escalate this situation if possible.

Phillip

> > What else do I have to do to make you stop bad-mouthing Squashfs?  Sue?
>  If you feel yourself better with that, be my guest. I don't know who
> is the lawyer of Debian, but I'm sure s/he can show you that it's only
> you who dance this storm.
>
> Regards,
> Laszlo/GCS
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D919207#5
> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D919207#83
> [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D919207#88
> [4] https://sourceforge.net/p/squashfs/code/ci/e38956b92f738518c297343996=
29e7cdb33072d3/log/?path=3D
> [5] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D921146#75
> [6] https://github.com/AgentD/squashfs-tools-ng
> [7] https://lwn.net/Articles/651775/
> [8] https://github.com/plougher/squashfs-tools/commit/f95864afe8833fe3ad7=
82d714b41378e860977b1
> [9] https://github.com/plougher/squashfs-tools/commit/ba215d73e153a6f2370=
88b4ecb88c702bb4d4183
