Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B52673410
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 09:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjASI6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 03:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjASI6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:58:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BE468404;
        Thu, 19 Jan 2023 00:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674118640; bh=QKC55KRrwm4FmCMM7ZjpR2Ch+0TKB6P79wpjtTYJZxE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OzqSMzUCT5JyPWtkuKmIkk4PH7yLBon1Qq+SMAKkwIriFhy9fddqerzE/zmjxGgl1
         9njbL775p4qBVjUs7vpaiPMOTbee6O4EMGBcN68YlX9KW14aySeYyIvPrP0RfMFAaV
         AOBEsXgArmxBSq/BlapPSo0UUpxgM+NVRq4Y31qTLiJGKK8XkCe40tTuWKvaP0pozK
         r3UfxqEcwK5ShEJAFqtTXtoDUFT5TggcVWgmVNNbu0R08TEySAkRtES1JxWWt1Jjim
         E23owomXuYSbZLw+Y3sSLeZ6NLPyFtrifTuTuq/fJTG4VFcNLH5hdHmITlzRHpKIBf
         zMrVfqu0l35bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from tibus.st ([37.221.194.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1pMZTC3kpN-004nUd; Thu, 19
 Jan 2023 09:57:19 +0100
Date:   Thu, 19 Jan 2023 09:05:32 +0100
From:   Stefan Tibus <stefan.tibus@gmx.de>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        Harald Arnesen <harald@skogtun.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Jfs-discussion] Should we orphan JFS?
Message-ID: <20230119080532.crn7wzo4jz5x5ng3@tibus.st>
Mail-Followup-To: Andreas Dilger <adilger@dilger.ca>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Harald Arnesen <harald@skogtun.org>, linux-kernel@vger.kernel.org
References: <f99e5221-4493-dba3-3e80-e85ada6b3545@oracle.com>
 <393B8E4A-8C9A-4941-9AFF-FAC9C0D0B2DA@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <393B8E4A-8C9A-4941-9AFF-FAC9C0D0B2DA@dilger.ca>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Provags-ID: V03:K1:iXEXS01C5YVpvNHOOvEKmVW0Vigu74L9c2nVpUt3/xkrm+raGy0
 zziGLiU9JcGdPueJK14m8goVogo1o6uAzMRqBtQPacp0PGd9npot6YMZYq1Totp0KsVFeZx
 K1k0h/uTjAK/uBIG2ZNA90KQBLbLEZIRI6x4huO35+xSmSCBZDunSNSRdxrlQgGbhj4Yl39
 TRQ2ULrGVAPLkDNjYau3g==
UI-OutboundReport: notjunk:1;M01:P0:7Kk14hf0FvI=;umrs9NNFVJ/HMONmf0Ix4XSWy3L
 Jhk6zpuUJe+gIeDWV/CPRtixr0CAmGdjGTGo7PXCHsed17J7ZPCn3JM6Af2qUl4tAhENg/HEW
 qpWgVjiRL6Jq75SiZMEMNOattbmE1UBRkvZCUPaEdMRT7NZ68/eiFhGJCuWPVPSjkv/DRx2bP
 ZTR0XU8M1l/U2TifawSmFQPA42rGIhjp4cM73RRTS+Wn/M/9zA17wla0e6jIrAkdKx1JiYziN
 7mRkr66GB+TTLnxtsD7LbLGoijydHKgDqSzcKiov9ZUNiWVhYyWqFbbmWmxN7kINDDzKnIkZA
 ebn4stPvU9Swc4wCaC/LE1Fzb+fgZLCOAvKe3eWzijN5esGBoROGQHwuy+HQ1aK/BSyA1LbF0
 s4Q+uQ1hYr08AQpmYdU1rTmj6RmFdX39K1xFdQm4ck/Pfc1GTaQ6M+6VAYcYqD7OPNEWG14FM
 /RYW5AIdglBQpUt7+xWfiW6/5Y0Xe9KCfM5H6TRoEQX2nTPIU2XCoW2xalGAPTIK/cQ6z9M+E
 zWIlGONU1x1+gnUm8NAKp7FF4Gv96TrBbXeiZT93znnIwet5iJDgUV/0oJHdo7VHXGobs4UUu
 fRAfQgPG2afZ8rWbUdDYMlwQICp//Cg6EQfoyRLXUvx7Ls2/LKrfcRK1Z1qWetBOwZ2XZYtFF
 J32yEREqyVpqbbbqGmgmbrgoOLzWLUZxO8tSP6s83VWuELB0lyqyu3QnE6Hbc5HvLZ/Iw6Qqo
 qKuxCKBVbCKPwz5AXv5ExjO8VJSSxGFzwMH5Lohp44zjItDg+a3UjXTK6wL97H0EzFW49s9qh
 /EcJmQC60FysBrAtLQHwvBbIqgkLDmhNvIITeb4hZTjodwc1homNzTgAKx7Z/ReiAurHC7zaF
 SuwBV0Y8lntek2jYPnGC6YL/9T86OdRDNAuCMh9yRfeczCfiZJe4+/eF8XD5yFC3i1H1rpMUX
 Me7eoLzkCDtX4Fj8lt3w3UMK8L8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

While I am mostly an ordinary user running Linux on my own machines at
home, I must say that I have been a happy user of JFS from quite early
on on all my Linux installations, for which I use the Debian distro. I
am also using it on external HDDs and SSDs. In the past I have also been
administrator for a few workgroup servers at my university for about 10
years and there we have transitioned from EXT2 and EXT3 to JFS on LVM at
some point. Only recently I have started using BTRFS because of its
additional features on my newest PC. However, I would not make that
transition on older PCs with less resources. And it is some hassle to
convert all existing filesystems to something else.

I cannot provide hard facts like performance or so for the decision to
use JFS. My first contact with journaling file systems had been on a few
AIX (3.x/4.x) machines and later on with JFS on OS/2. So having started
off based on the code of JFS for OS/2 certainly contributed to the
initial level of trust when giving JFS on Linux a try versus EXT4 and it
didn't let me down.

=46rom my perspective it would be sad seeing it removed while other much
older filesystems (or other features) are retained. But I also know that
in the end it depends on the capability, availability and willingness of
developers to maintain it. And, frankly speaking, I really do not know
how much effort it is to keep the code compatible to new kernel
versions.

So this is my vote against orphaning JFS. I still think it is a good
filesystem and certainly useful on systems with less resources where one
would probably not use BTRFS, ZFS or so. But whatever the final decision
will be, I would like to thank you all for contributing to JFS and
keeping it running over the past >20 years.

Best regards
Stefan


On Sat, Jan 14, 2023 at 05:09:10AM -0700, Andreas Dilger wrote:
> On Jan 13, 2023, at 08:15, Dave Kleikamp <dave.kleikamp@oracle.com> wrot=
e:
> >
> > =EF=BB=BFOn 1/13/23 7:08AM, Harald Arnesen wrote:
> >> Christoph Hellwig [13/01/2023 06.42]:
> >>> Hi all,
> >>>
> >>> A while ago we've deprecated reiserfs and scheduled it for removal.
> >>> Looking into the hairy metapage code in JFS I wonder if we should do
> >>> the same.  While JFS isn't anywhere as complicated as reiserfs, it's
> >>> also way less used and never made it to be the default file system
> >>> in any major distribution.  It's also looking pretty horrible in
> >>> xfstests, and with all the ongoing folio work and hopeful eventual
> >>> phaseout of buffer head based I/O path it's going to be a bit of a d=
rag.
> >>> (Which also can be said for many other file system, most of them bei=
ng
> >>> a bit simpler, though).
> >> The Norwegian ISP/TV provider used to have IPTV-boxes which had JFS o=
n the hard disk that was used to record TV programmes.
> >> However, I don't think these boxes are used anymore.
> >
> > I know at one time it was one of the recommended filesystems for MythT=
V. I don't know of any other major users of JFS. I don't know if there is =
anyone familiar with the MythTV community that could weigh in.
> >
> > Obviously, I haven't put much effort into JFS in a long time and I wou=
ld not miss it if it were to be removed.
>
> I've used MythTV for many years but haven't seen any particular recommen=
dations for JFS there. Mainly ext4 and XFS are the common filesystems to f=
ollow the main distros (Ubuntu in particular).
>
> Cheers, Andreas
>
> _______________________________________________
> Jfs-discussion mailing list
> Jfs-discussion@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/jfs-discussion
