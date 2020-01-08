Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B59134B94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgAHTlN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 8 Jan 2020 14:41:13 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgAHTlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:41:12 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MWhxY-1jDV5r0huy-00X3aU; Wed, 08 Jan 2020 20:41:11 +0100
Received: by mail-qk1-f171.google.com with SMTP id z14so3746989qkg.9;
        Wed, 08 Jan 2020 11:41:10 -0800 (PST)
X-Gm-Message-State: APjAAAUMd5ceqXieUYjK3VvbkI+DjiNGgHgcNNv/KLMF//hSG0MuUQMS
        bgoHTRpd6h8KqbuxKL+GbvoZDNAqOxFzBd8/Jq8=
X-Google-Smtp-Source: APXvYqxiVPuIo2aUDi5vmlJyIky/kJTYp0QIReiwM5NicLbcufc/SzKdNmgsBGBMHO/ACmG5dNsjq1WsefdzjW6nvKI=
X-Received: by 2002:a05:620a:cef:: with SMTP id c15mr6064016qkj.352.1578512469958;
 Wed, 08 Jan 2020 11:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com>
 <20200102082036.29643-10-namjae.jeon@samsung.com> <20200102091902.tk374bxohvj33prz@pali>
 <20200108180304.GE14650@lst.de>
In-Reply-To: <20200108180304.GE14650@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 20:40:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0S6DBJqDMj4Oy9xeYVhW87HbBX2SqURFPKYT8K1z7fDw@mail.gmail.com>
Message-ID: <CAK8P3a0S6DBJqDMj4Oy9xeYVhW87HbBX2SqURFPKYT8K1z7fDw@mail.gmail.com>
Subject: Re: [PATCH v9 09/13] exfat: add misc operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:2TDjqw8FMGsB5SM5iyToeENVJTWUamr8vTUyiILIVhTDwyqDik4
 ELVH1/L7BhrDoaKOQss1N1HGwjeoR/8qG+ARob2zwEZ/VBELbhUXhlf84YhIl4r39835LaX
 JDL5rS5WAOHBcHbkrtyDy283xT6q2zx8Cz4cNLVI4OlVyilZAdg6NTQ34tuHs7g1VlWxgeW
 jl0Ves0KXNNNeGYi8u63g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l1DlwR/VxLM=:OJGxiFzXpjf6MoBNLVEcrW
 37BTBmKJYaSR0Plwza0jhlV9fH3rt7aSCjAVj6ODByZNUdP005m8HJ7pP27X1+pma1vvnNwFd
 EofiJtuqebJi9mqPAdL4XBxXvGog/p442EQxZBixzi5WTqfsyCgD/ALNMIzq+cTLajLrX3hSa
 ZJYsWvh2V7iB6UP71hfjIibf+kr00+vB1fnVUR+62Vg3r/35Kv3rWdJQET4B8p1+ov5CiuXyF
 SfiUM0BR8pGTSQT+Q2EBpwhTim//Nhs1kvywodHirZ4aUKuVcLGyTYmdklTMj+uxJY6YZ7vqu
 HJxEydTbcg8V/RT4lJ5Xbj2ztiKJBkV8olFzwQucwmKPi4yQ3bw9g0uKr4DQex9B3In1bbI5o
 AdQgAd50/n8p+YJvPJaSytgD7H9VknRC4jeu6Kdr29VDF+Nd40GVQZ5f2s4Jbtlvy1wVVY2k/
 U7I7yB20PmjvfX2LATOdNj+wJRDOCUf/ybztSa4r62k81x7bXsDOlt0gF669PXNkRMRY8uqs+
 raBXmcMCWxAerAQGsJwSuSh4J9csNzXjYfnljJysEWwwiQm7jzY3nrfxmmbVCYWaBW/6Abj7D
 dAH14ij7H7j2Ecg337Mi/8+Rmu3XKlE5WiZrz5PxlSXiOx0vwN7qlBXz3Aeu9mIbKokRtm15E
 WH1ozlIHr2p1cnNanK9Nf9zeUkN9aeY+MoaunQgozCxfQNTeoudTD+sVLUDmxFwosdp4KHLZO
 ueWYIrko6VrZZQ5fTIMtVqiZGZrODNggO8k3EFwbU5N8+QpenhiyScxrmsA/IlAbWZ0vd0MAJ
 fkKbqk0xX37E4F1O0SCswbLJnsFbMrQLvx6VsxDPstaOqLdVhGpGeBLYZKrajVsbSGkxVTLs5
 vHJvRrNyZiwhWjLLfHLg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 8, 2020 at 7:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Arnd, can you review the exfat time handling, especially vs y2038
> related issues?

Sure, thanks for adding me to the loop

> On Thu, Jan 02, 2020 at 10:19:02AM +0100, Pali Rohár wrote:
> > On Thursday 02 January 2020 16:20:32 Namjae Jeon wrote:
> > > +#define TIMEZONE_CUR_OFFSET()      ((sys_tz.tz_minuteswest / (-15)) & 0x7F)
> > > +/* Convert linear UNIX date to a FAT time/date pair. */
> > > +void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *ts,
> > > +           struct exfat_date_time *tp)
> > > +{
> > > +   time_t second = ts->tv_sec;
> > > +   time_t day, month, year;
> > > +   time_t ld; /* leap day */
> >
> > Question for other maintainers: Has kernel code already time_t defined
> > as 64bit? Or it is still just 32bit and 32bit systems and some time64_t
> > needs to be used? I remember that there was discussion about these
> > problems, but do not know if it was changed/fixed or not... Just a
> > pointer for possible Y2038 problem. As "ts" is of type timespec64, but
> > "second" of type time_t.

I am actually very close to sending the patches to remove the time_t
definition from the kernel, at least in yesterday's version there were no
users.

exfat_time_unix2fat() seems to be a copy of the old fat_time_unix2fat()
that we fixed a while ago, please have a look at that implementation
based on time64_to_tm(), which avoids time_t.

      Arnd
