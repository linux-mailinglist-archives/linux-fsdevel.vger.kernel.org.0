Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28343A329A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 19:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFJSAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 14:00:50 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34615 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFJSAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:00:49 -0400
Received: by mail-oi1-f177.google.com with SMTP id u11so3031716oiv.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AZ3YqRmR3v8qpJWVlW+h7dFt8AAllw39DawhyDxuAHA=;
        b=mywSRb8veBcmHJ9q3Zg0eLzlNA7O6JQ4YJNeYQHPSK6vCzimgYMSnw7EwXEaZyb49k
         Xrk+FJx8e/92HLroUm8YJ7X4NaMLesTCusuJdXT0uoLMmiLO3ME9axzw/aPKY2ZbO7QX
         ZsfkWVfidCKaBrWF8qfZxsqxPkR57VsZvyD+vnJzJ5PDUigeO/03cTcPSmBYLBqkWojR
         vf9QpypJ+4HWQ2ytrTyWvwMbuUq+JlZhlCSfSXUqCftbB5DAqJOonunB/Hs1r8RW1Mpx
         kn0aqbcIMhiZK2yez6+KiPUsKIPgAcuGwZdbDJrbSqARjxM8egu0q9zF+u4xFEVDdgjj
         /G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AZ3YqRmR3v8qpJWVlW+h7dFt8AAllw39DawhyDxuAHA=;
        b=gRDeis+evtwqcx35bcxO87NMBeU3ty5yOArwqu2LUNGyVP5JcJQmlqPNpu9pgdmtRK
         lml9GrhEVKnj+ctJoZEgHowmnxYcGFrD+LhDLw1C4twvzGwxZO3MRiVx3GFhQNOxN2FD
         tqJTTictEDPkpBD7YiaAYUwovveVMFs58D2wPClFoaCIDiQLiQLPIKBYD3Q2UhAuNq6a
         YWeeIflYbJmmlFq6XT4W1VF3SHfwcM/LOvYZc1wt4jioiPXVFPXy6jt+/odOwAUmXzIl
         oc/PcQByuyum17BaK8bM4B8QkNlzA+hQ57yb42Y2Vy29gaskr+Pid7hTyxTqoKUD8nbW
         Cb5A==
X-Gm-Message-State: AOAM530PsdQQjtF8AoAO4hG5KuaiOCG8pm4bIy09gSiYIh81URePvYFw
        mhLfn9qvKmZohtxikC3137y6Ww==
X-Google-Smtp-Source: ABdhPJxElrlse/A/8ExkMkCIRy0cOS1SkxlnjBWSpeu5xICJpMuBAAx7UHNE/TEky/jASpnZIDD7Og==
X-Received: by 2002:a05:6808:6c4:: with SMTP id m4mr4367989oih.88.1623347859107;
        Thu, 10 Jun 2021 10:57:39 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:6d23:ba39:5608:8e4d])
        by smtp.gmail.com with ESMTPSA id d20sm739658otq.62.2021.06.10.10.57.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 10:57:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <eafad7a6-4784-dd9c-cc1d-36e463370aeb@gmail.com>
Date:   Thu, 10 Jun 2021 10:57:35 -0700
Cc:     Jaegeuk Kim <jaegeuk.kim@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <973FD16E-0F60-4709-924E-8D15245C4EDB@dubeyko.com>
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
 <CAOtxgyeRf=+grEoHxVLEaSM=Yfx4KrSG5q96SmztpoWfP=QrDg@mail.gmail.com>
 <eafad7a6-4784-dd9c-cc1d-36e463370aeb@gmail.com>
To:     Ric Wheeler <ricwheeler@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 10, 2021, at 9:22 AM, Ric Wheeler <ricwheeler@gmail.com> wrote:
>=20
> On 6/9/21 5:32 PM, Jaegeuk Kim wrote:
>> On Wed, Jun 9, 2021 at 11:47 AM Bart Van Assche <bvanassche@acm.org =
<mailto:bvanassche@acm.org>> wrote:
>>=20
>>    On 6/9/21 11:30 AM, Matthew Wilcox wrote:
>>    > maybe you should read the paper.
>>    >
>>    > " Thiscomparison demonstrates that using F2FS, a flash-friendly =
file
>>    > sys-tem, does not mitigate the wear-out problem, except inasmuch =
asit
>>    > inadvertently rate limitsallI/O to the device"
>>=20
>>=20
>> Do you agree with that statement based on your insight? At least to =
me, that
>> paper is missing the fundamental GC problem which was supposed to be
>> evaluated by real workloads instead of using a simple benchmark =
generating
>> 4KB random writes only. And, they had to investigate more details in =
FTL/IO
>> patterns including UNMAP and LBA alignment between host and storage, =
which
>> all affect WAF. Based on that, the point of the zoned device is quite =
promising
>> to me, since it can address LBA alignment entirely and give a way =
that host
>> SW stack can control QoS.
>=20
> Just a note, using a pretty simple and optimal streaming write =
pattern, I have been able to burn out emmc parts in a little over a =
week.
>=20
> My test case creating a 1GB file (filled with random data just in case =
the device was looking for zero blocks to ignore) and then do a loop to =
cp and sync that file until the emmc device life time was shown as =
exhausted.
>=20
> This was a clean, best case sequential write so this is not just an =
issue with small, random writes.
>=20
> Of course, this is normal to wear them out, but for the super low end =
parts, taking away any of the device writes in our stack is costly given =
how little life they have....
>=20
> Regards,
>=20
>=20
> Ric
>=20

I think that we need to distinguish various cases here. If we have =
pretty aged volume then GC plays the important role in write =
amplification issue. I believe that F2FS still has not very efficient GC =
subsystem. And, potentially, there is competition between FS=E2=80=99s =
GC and FTL=E2=80=99s GC. So, F2FS GC subsystem can be optimized in some =
way to reduce write amplification and GC competition. But I believe that =
the fundamental nature of F2FS GC subsystem doesn=E2=80=99t provide the =
way to exclude the write amplification issue completely. However, if GC =
is not playing then this source of write amplification can be excluded =
from the consideration.

The F2FS in-place update area is another source of write amplification =
issue that expected to be managed by FTL. This architectural decision =
doesn=E2=80=99t provide some room to make optimization here. Only if =
some metadata will be moved into the area that is living under =
Copy-On-Write policy. But it could be hard and time-consuming change.

Another source of write amplification issue in F2FS is the block mapping =
technique. Every update of logical block with user data results in =
update of block mapping metadata. So, this architectural solution still =
doesn=E2=80=99t provide a lot of room for optimization. Maybe, if some =
another metadata structure or mapping technique will be introduced.

So, if we exclude GC, in-place area, block mapping technique and other =
architectural decisions then the next possible direction to decrease =
write amplification could be not to update logical blocks frequently or =
to make lesser number of write operations. The most obvious solutions =
for this are: (1) compression, (2) deduplication, (3) combine several =
small files into one NAND page, (4) use inline technique to store small =
files=E2=80=99 content into the inode=E2=80=99s area.

I believe that additional potential issue of F2FS is the metadata =
reservation technique. I mean here that creation of a volume implies the =
reservation and initialization of metadata structures. It means that =
even if the metadata doesn=E2=80=99t contain yet any valuable info then, =
anyway, FTL implies that it=E2=80=99s valid data that needs to be =
managed to guarantee access to this content. Finally, FTL will move this =
data among erase blocks and it could decrease the lifetime of the =
device. Especially, if we are talking about NAND flash with not good =
endurance then read disturbance could play significant role.

Thanks,
Slava.






