Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D513C399
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAONua convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:50:30 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:44779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAONu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:50:29 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MacWq-1jOIvZ1STS-00cBGy; Wed, 15 Jan 2020 14:50:27 +0100
Received: by mail-qv1-f41.google.com with SMTP id dc14so7338848qvb.9;
        Wed, 15 Jan 2020 05:50:27 -0800 (PST)
X-Gm-Message-State: APjAAAVQPx15b4AjJCGeywdptelLsYDvuGQ48fq4a10RRa0QG2HQwmE7
        94tVMQXPfT0+x1OkwMSEj96eg0ITnaOXllAmUHM=
X-Google-Smtp-Source: APXvYqyl7uNQv+weHDkj+4n/1x08jQKkMwbhnzB0cjncUcoprt2VN7a56hddZyTo34cvRVHUb+kjlRzLrmpR32DvACo=
X-Received: by 2002:a0c:d788:: with SMTP id z8mr20822765qvi.211.1579096226126;
 Wed, 15 Jan 2020 05:50:26 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com> <20200115133838.q33p5riihsinp6c4@pali>
In-Reply-To: <20200115133838.q33p5riihsinp6c4@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 14:50:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
Message-ID: <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Y8h8lkSOLNjm7tnDH8hZQmI38TXya9ENaqh+Nr2XlDYvbVlqPPZ
 +9xPSGXEAK8bs+iwj/d540d5PdsXjr6Wy3/KbHy0ZZAezmdYmuHRLdxHKSNdV5/YbojH/Q0
 l7oD6eofrv3vtMfmuraBRNxg535jQC4YwrkvKR3hqGJQ3bGbXDHLcVw0WhL/AtlUpUFBw4g
 HiNR8k0ivYv3ajYUkCUmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+bu4/c32c1g=:44YrMUmOErEQchdHl7bXCz
 aOpSaBMkZIlqbAdiX/DFYl8YRHJmNHnVuiT1g8JyAgAtVPQQzArjv4n6KtwaBw6fGj9W/woNj
 LJnce+RXGEsAxT9S7jlOeaz23TGLprKLm6um/JVD9d8wc1exNeMSlV6qQt1dRzaue6ZViJF40
 izZ/bRf8MJ3sppuinfQRZmyJGdbNyKbbGP7eYtF70NJv6clczVrfAY2WZFO7KEotfXAv1I0W8
 7TmInzH6TdGe6Ek0ZA6BP1oQW+ktqSBcxYTP/wWtydHfMsybxfpiuUKuLG0zHiAtJUIANERMn
 TILdQvfNUPYwQLpb/IUSEjbdzyqBePo306iF27wnXLVWgSS2Mi35V7xr3gbr1lO2LBTaSCe36
 ZwOIgVJ9YwyhlLTEDO34xLCh3YK/DwDjteQq9k1lsyEmWkToaPv6QGXZz+3/S9HQ3Ow0mYCHs
 QHNLqb7RE1gqzTIcWqT1+jc0NQOKiwoGrgxpPLCpgU2RSytzl6rzPaFy9D96Gor5o5jdSDob1
 A5PAleLeS0vdH9G1hYAfwUePVXNnmXVnh+Rzp+3j3LSpTZ9GFDxh/O44cbeh9hig7w28CcFC3
 +PJUMGSxXEP6s1sx/x/b071EJ6oj0rNyzOaim5LtzTm1ul5wo//C1Cl0eFB/hBrXzjbsKV3Hr
 9PrnXsFMVdAqGtQN2JV492j6kQZ8DcI7CCQrhZp7Eac8P6n16pfyJqVpoGzpIw2zsayr8rQsn
 Pay3I9krsbE+GHTZcUJFkR0WdKur2YTaoLHLQ4vpt844LwIbalYlN5+HRjVtrgpXaYKVwi/v3
 voBal+RL7H5lUOO9cMoIziGklKR6synGPPtcYU/neHF/qSu19IoXLfGiwTZgU9VCG6mV7QiNb
 Heq9LyPkl4J6RxNDMMvQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 2:38 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> On Wednesday 15 January 2020 22:30:59 Namjae Jeon wrote:
> > 2020-01-15 19:10 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:

> > It is not described in the specification. I don't know exactly what
> > the problem is because sys_tz.tz_minuteswest seems to work fine to me.
> > It can be random garbage value ?
> >
> > > so if there is a choice, falling back to UTC would
> > > be nicer.
> >
> > Okay.
>
> Arnd, what is the default value of sys_tz.tz_minuteswest? What is the
> benefit of not using it?
>
> I though that timezone mount option is just an old hack when userspace
> does not correctly set kernel's timezone and that this timezone mount
> option should be in most cases avoided.

The main problem is that it is system-wide and initialized at boot
time through settimeofday() to a timezone picked by the system
administrator.

However, in user space, every user may set their own timezone with
the 'TZ' variable, and the default timezone may be different inside of a
container based on the contents of /etc/timezone in its root directory.

> So also another question, what is benefit of having fs specific timezone
> mount option? As it is fs specific it means that it would be used so
> much.

You can use it to access removable media that were written in
a different timezone, or a partition that is shared with another OS
running on the same machine but with different timezone settings.

     Arnd
