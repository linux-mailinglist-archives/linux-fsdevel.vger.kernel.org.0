Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754024C85C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 09:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiCAIBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 03:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiCAIBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:01:24 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D050B33;
        Tue,  1 Mar 2022 00:00:43 -0800 (PST)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFba4-1nQdmn3WWM-00H7XW; Tue, 01 Mar 2022 08:48:03 +0100
Received: by mail-wr1-f41.google.com with SMTP id j17so19072331wrc.0;
        Mon, 28 Feb 2022 23:48:03 -0800 (PST)
X-Gm-Message-State: AOAM532e3u1KYUIWqN/k9DvfmsXq6N9V1DYsY8WiF0cOYnkYc+Ejwi+H
        20cXQ2+rAAcL9eAj+KOkuOXaVeaNAoj0HvoGpO0=
X-Google-Smtp-Source: ABdhPJx7xFc8d8ZUqhFw0cOHN4eIGNzbF0v+cj0w7vw4NhchZOTiEJak7JkMPaKdSavIGq6u6AvPB68dPMZnxZbY6T8=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr10059930wrh.407.1646120883265; Mon, 28
 Feb 2022 23:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20220201013329.ofxhm4qingvddqhu@garbanzo> <YfiXkk9HJpatFxnd@casper.infradead.org>
 <Yh1CpZWoWGPl0X5A@bombadil.infradead.org>
In-Reply-To: <Yh1CpZWoWGPl0X5A@bombadil.infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Mar 2022 08:47:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a137DDbMN90neSCiQ7+B2o-NpWpCZ5PAEs34PBNCdAE7Q@mail.gmail.com>
Message-ID: <CAK8P3a137DDbMN90neSCiQ7+B2o-NpWpCZ5PAEs34PBNCdAE7Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:it895dGxNVhkF80DvHJ/bKRAnC6bnMCKdRlTiIPDz7umFYszHJi
 BRaufOiJ2/uLHkHHuRKgk34IreqG9YDALQNJLnvuu59yLynbht23Tp9iJcUMl0x5h0di26Y
 IqDcaJ0bbpZEJ4+4B7IjppLQDlVNo9QVmfF2MtGGKj5F/LSzR8I83RsuQz0zP/nmqBkog4T
 kw1qjk+16yGBq+JLVfW3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FjiWjFFc5Jc=:GnVF/9ZtbWY5WLs1h/0A2I
 Mra2NP3X1T/GlRBF53/AMO9coOgZKxjitj/0Vikx9mIlJPp5ua1CdqT+Fsqqd5BK+9Qt01XY/
 4onFfSZHJNRc+1Q7NfNgyG6OO6u68jswZbK2YNnQgy37OohowWmRPXi5BwBIBsnK1QpCfdNOW
 3PUKcDDis5qb9l0VXx/UVMBZae3zc6ywV2fbd9lnJTcmao3KdxSnLCaN3KhVCaG6AKpfwYQcX
 DseSW1jAuQDu9QQ9VyyfQM4boIhWH89yXT5d78v+2ygXHUINg2i4L7sr2SDSGnS0uS88EbaE9
 sNJWjCgsY8zHmAm73WfCcRhc3voyFtRqZ6LFDI9vomD66lIcxvdy6zdkTahJryffOX5nBUI8o
 WGp5onfetojjulus0ckHjvx8vkKMquDxFcHiQLdavyRdpv33sVWrZfmHVuBgYH4pXZ5MPn9lJ
 o9SKEQgRlmuoNgqzPoV4GyogULv39caFPIgNys9U/AFaggJPpe7xRxXhPFSDV7z9Cs2d2UXTX
 I8C54h0CZkpgts1ho2WfDAaE/wLW5d9NvSPcmiWZykyyQfO3BObSeLcvTOcNem9ai6Cteu1t5
 Q0V36EHsiBc+R2ogbEipV4DGNNRO4uGpcQUIR/h0IdodHP7I5a86hMC4jM71xtp9zEo94RUIJ
 xMWY5Dpg4rGUdIROfwYU9bmp6wRPi3OzAxCUXBqJyPEYg4waFsU7LD1TRlZ8OXUHilrJhwVBG
 ZIubyQ1kapGkH8pRX8sFRIahCcdVQBFKkoDiGP/BqrLlw5byzJoCk2waTQmwI7IvVsHKmM918
 mFEueZZowKXdfw/81/46j1mny/qoQSre4PdzoWTxirSU+SUkCg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Tue, Feb 01, 2022 at 02:14:42AM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 31, 2022 at 05:33:29PM -0800, Luis Chamberlain wrote:
> > You have to get it into each architecture.  Having a single place to
> > add a new syscall would help reduce the number of places we use
> > multiplexor syscalls like ioctl().
>
> Jeesh, is such a thing really possible? I wonder if Arnd has tried or
> what he'd think...

Definitely possible, Firoz Khan was working on this at Linaro, but he
never finished it before he left. I still have his patches if anyone wants
to pick it up, though it might be easier to start over at this point.

The main work that is required here is to convert
include/uapi/asm-generic/unistd.h into the syscall.tbl format,
with a number of architecture specific conditionals to deal with all
the combinations of syscalls that may or may not be used on a given
target.

After that, I would modify the scripts/syscall*.sh scripts to allow
multiple input files, splitting the architecture specific numbers
(under 400) from the newer numbers (over 400) that can be
shared between all architectures in a single location.

        Arnd
