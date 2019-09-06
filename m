Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C460ABE6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395174AbfIFROU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 13:14:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43393 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395166AbfIFROU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:14:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so3826528pgb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hOgSaQ9OiZSGTbwU3Edr701ZO2qKZIOjSVp4gAjrJTU=;
        b=yd2a+54PEaXqiHA9W/77hkPN2VhfSOlLkSERJRJ/Bh1zlws9GocZGNGdm3pxHNPP2k
         apcVkjkZdq9vP5K898Y0K0fp9Msz4ZIqXGLi1k3bvPTRUs1UDb+7WxEM6JDLxMiQC9Wu
         hspuXC71/2nCgTYC+nFZhbQMqN+6eyywKJmqPax8RWIZzApVcyFl5TPK/9Tjjmez1ZGz
         l0D7JZ/pzEMsGILSnd+o1gvbgawAXhr39KQszkwTSRT6FrgwFODq1N4F8fWIgP3aj4VH
         YyfGqiifL7/wZTGB2yK1JGhsxMeKoGttY75RNEmXrHy9j6PIB31lmiA0uGmL+SbUOsUT
         Xwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hOgSaQ9OiZSGTbwU3Edr701ZO2qKZIOjSVp4gAjrJTU=;
        b=iufz0tO6Dxz9/IPxoSY3mP2O9J9b44xJVOfKLz48Wh2b8kQN3cfDmqdHKnLyM6Ofic
         I5uGMRbtTLaYH47KnxI9jLnj7IcUCX+W7mpK7xANsQrhq2wZBJlI9snA8ezPzFhCQVyd
         o6UMmnZdrZlHU8GWTPixM+jlDo0EYnZUKJfIx+e1cOdGIBmVGtuRgWXB6Psg1sJ/syUJ
         +zJN2/+EPy+vA4yYCGRj+IeOrQMYKVHHJ4jkvgBajQuZhGNh+INVrTpjTqfPnom5KSKm
         RttPTfNubwJMskX0XSx6tKTyfZOBijpbCBQU9TfjKhG7xnVHyuHYphIB1zK/pnVONZK5
         gGgQ==
X-Gm-Message-State: APjAAAU1WBZ1ZvZzi1mrxCxeNnm1tS0rE9RVRgpb+3e5bXcVefnwsIu5
        y/LS3OIsDXHGDnNaJCVPaIVKgOxpHEI=
X-Google-Smtp-Source: APXvYqxbn2eHgWIJBYiC3a5/vs29BS1qCgh/M+Xwxl6za2nTiM7gcJSTtHUvTCE+hcKMSoFjghMKew==
X-Received: by 2002:a63:7e17:: with SMTP id z23mr8935117pgc.14.1567790058681;
        Fri, 06 Sep 2019 10:14:18 -0700 (PDT)
Received: from ?IPv6:2600:100f:b121:da37:bc66:d4de:83c7:e0cd? ([2600:100f:b121:da37:bc66:d4de:83c7:e0cd])
        by smtp.gmail.com with ESMTPSA id l11sm4930140pgq.58.2019.09.06.10.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 10:14:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Why add the general notification queue and its sources
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <8e60555e-9247-e03f-e8b4-1d31f70f1221@redhat.com>
Date:   Fri, 6 Sep 2019 10:14:17 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <930B6F39-4174-46C2-B556-E98ED72E27F8@amacapital.net>
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk> <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com> <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com> <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com> <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com> <5396.1567719164@warthog.procyon.org.uk> <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com> <14883.1567725508@warthog.procyon.org.uk> <CAHk-=wjt2Eb+yEDOcQwCa0SrZ4cWu967OtQG8Vz21c=n5ZP1Nw@mail.gmail.com> <27732.1567764557@warthog.procyon.org.uk> <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com> <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com> <8e60555e-9247-e03f-e8b4-1d31f70f1221@redhat.com>
To:     Steven Whitehouse <swhiteho@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 6, 2019, at 9:12 AM, Steven Whitehouse <swhiteho@redhat.com> wrote:=

>=20
> Hi,
>=20
>> On 06/09/2019 16:53, Linus Torvalds wrote:
>> On Fri, Sep 6, 2019 at 8:35 AM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>> This is why I like pipes. You can use them today. They are simple, and
>>> extensible, and you don't need to come up with a new subsystem and
>>> some untested ad-hoc thing that nobody has actually used.
>> The only _real_ complexity is to make sure that events are reliably parse=
able.
>>=20
>> That's where you really want to use the Linux-only "packet pipe"
>> thing, becasue otherwise you have to have size markers or other things
>> to delineate events. But if you do that, then it really becomes
>> trivial.
>>=20
>> And I checked, we made it available to user space, even if the
>> original reason for that code was kernel-only autofs use: you just
>> need to make the pipe be O_DIRECT.
>>=20
>> This overly stupid program shows off the feature:
>>=20
>>         #define _GNU_SOURCE
>>         #include <fcntl.h>
>>         #include <unistd.h>
>>=20
>>         int main(int argc, char **argv)
>>         {
>>                 int fd[2];
>>                 char buf[10];
>>=20
>>                 pipe2(fd, O_DIRECT | O_NONBLOCK);
>>                 write(fd[1], "hello", 5);
>>                 write(fd[1], "hi", 2);
>>                 read(fd[0], buf, sizeof(buf));
>>                 read(fd[0], buf, sizeof(buf));
>>                 return 0;
>>         }
>>=20
>> and it you strace it (because I was too lazy to add error handling or
>> printing of results), you'll see
>>=20
>>     write(4, "hello", 5)                    =3D 5
>>     write(4, "hi", 2)                       =3D 2
>>     read(3, "hello", 10)                    =3D 5
>>     read(3, "hi", 10)                       =3D 2
>>=20
>> note how you got packets of data on the reader side, instead of
>> getting the traditional "just buffer it as a stream".
>>=20
>> So now you can even have multiple readers of the same event pipe, and
>> packetization is obvious and trivial. Of course, I'm not sure why
>> you'd want to have multiple readers, and you'd lose _ordering_, but if
>> all events are independent, this _might_ be a useful thing in a
>> threaded environment. Maybe.
>>=20
>> (Side note: a zero-sized write will not cause a zero-sized packet. It
>> will just be dropped).
>>=20
>>                Linus
>=20
> The events are generally not independent - we would need ordering either i=
mplicit in the protocol or explicit in the messages. We also need to know in=
 case messages are dropped too - doesn't need to be anything fancy, just som=
e idea that since we last did a read, there are messages that got lost, most=
 likely due to buffer overrun.

This could be a bit fancier: if the pipe recorded the bitwise or of the firs=
t few bytes of dropped message, then the messages could set a bit in the hea=
der indicating the type, and readers could then learn which *types* of messa=
ges were dropped.

Or they could just use multiple pipes.

If this whole mechanism catches on, I wonder if implementing recvmmsg() on p=
ipes would be worthwhile.=
