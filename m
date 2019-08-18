Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF5918E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfHRScH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 14:32:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:39519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRScH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566153082;
        bh=JnSOVaSr8ZMfWjAXv4Mm3x6HT+bnyfuADTLNgCCBU3s=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=W59CkNbLUNAjJ7USev9l7fXD+Z+K9BfIaTpUBh7Bj7qK4HON80gQ640oPrBB1Dc61
         VpvvPPyDQBV82IyxCfz75zyOi1ZMLCONioEc+9b8g2UH8PnWDsEmsM/43SZxw1YdrQ
         x1kHIO6Tcg+ZxTY69RBfT9sYSIdKsCj6Cy9b/k7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([115.197.242.96]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Lb5GD-1iepNI0Ctd-00kf6J; Sun, 18 Aug 2019 20:31:22 +0200
Date:   Mon, 19 Aug 2019 02:31:05 +0800
From:   Gao Xiang <hsiangkao@gmx.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     tytso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.cz>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818183104.GB1617@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <1897345637.69314.1566148000847.JavaMail.zimbra@nod.at>
 <20190818174621.GB12940@mit.edu>
 <538856932.69442.1566151228866.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <538856932.69442.1566151228866.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:H+NFCf0wlqRcqkLlPam7c5tw+KObwz8nlqwhdtnkWhSReB61qKl
 F1fRmaMOcEwjjy47KN8sdZ1Nk/+0402ISuwlyXPlwfJQstQFGVihGeyZdqeQJasAygKYq2Z
 xcEfL1e/z/LZK01QHjhFsQhPIhw+Hojr493apR3fT3uYUv6ggEieajZZwysC9q/TQOFjLtk
 Waa/H1RdohVdkujV0ShNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YKP+DUme9FE=:EdYyDDF+QXnnkddLceeaol
 lUp/Y5zJTjISBcJe7r4rAmC2303gSu3GOI3nXQ56gfGojcO+oL2dX2+sWykSAf/3Ft76t053h
 CKInXxdZ4EX5YnPypdPOn3PlIhn2vW/wvm5j1lF2gXvqzEWXgh0D0zlZqrW2YIMW2Y56jFHRO
 p7rxicoAiT6jER70sDhOunPny/X/D9ft+AoWkNFiG8RB/fGURNG5HpLAAruteq3JyE8Off8Q6
 DhL8fy6lMG4rShVavuZcOc82Q+CUc563Lf1lstLzmOEJSuBNuBNshWRTIe4Y7XNrNdhwSqmQF
 /9KDo4ewO6j9JTudL0s/UJ7qMqEROqaCYhfSlWOyQgvWyR7xL+tqfq2ZziFRSwwNhUQOL7ONh
 fd4fiTIm7/EqNg5/+Tl4Klb81v1DiWjB8IWJFPwxgPsT54orXmpbh1MMIAHlk8MlYd25Dpk1F
 fbKOd5Bg/wHcFjVgs5m3jyRj9Hqy7gLJ0F9pre1hfSnX1U4tuKYeFxEdr1dtC7YbAD3Yeqf8X
 LBsqecZeZMyI1xEg5PSTLI+K14rZ15HsfJZ/HUMPgUipgECHHcFdDQzss4Sy6tqBIP3KAZTHt
 xQ8lTnUWPlH6Sszn98kcQpSZqWnrg4DQar4XdID3jFdjrneKpMPEYCWwBQ6MCl46G2bmMLtP7
 6pDuPNdIYeiMy2nrs+rPOYOAVDZotDOv6dEBwinn24Spnmf/PPL+9S+XYD9L0pfdI7aQOXL6T
 F0gTIOlPp6NvepwXiLU/oCqW2+7BIzHuuILKKZTnECF1PCS8mC7Ekt/U+MrzgOz8rdM/N65vR
 ynRwLoZ3qFpgvW6NM7tqKMTnBdlnH2jaWoKaVhn3Wx2W4C01zHwWL/4saWPEiBjfNcbHPnHs5
 rntaFgJZb2iRpcTwxeg+5aZhghQMPHR5NxrUjDm01xzSGun1gdbyD+Yy6Mpi3d1+g5nwHExwZ
 DISTC61UjNkdRD5a5Tqrulvis/0DuT64pa5+GPKF31L7h298i61XJHYPD0kH+J0+Re1qNiVMl
 tU/X64eDZh1jGufmquTCEy1VwuarL3sKid5KyuI3sbo61IivGz2yzovTntrpPEw5svjpVUtKz
 lt5QNwKxE1gbzvR1crZNH/8jpf+RkE/RMwfsN23afEwBdLjh0DicfVLPA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

On Sun, Aug 18, 2019 at 08:00:28PM +0200, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "tytso" <tytso@mit.edu>
> > An: "richard" <richard@nod.at>
> > CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Gao Xiang" <hs=
iangkao@aol.com>, "Jan Kara" <jack@suse.cz>, "Chao
> > Yu" <yuchao0@huawei.com>, "Dave Chinner" <david@fromorbit.com>, "David=
 Sterba" <dsterba@suse.cz>, "Miao Xie"
> > <miaoxie@huawei.com>, "devel" <devel@driverdev.osuosl.org>, "Stephen R=
othwell" <sfr@canb.auug.org.au>, "Darrick"
> > <darrick.wong@oracle.com>, "Christoph Hellwig" <hch@infradead.org>, "A=
mir Goldstein" <amir73il@gmail.com>,
> > "linux-erofs" <linux-erofs@lists.ozlabs.org>, "Al Viro" <viro@zeniv.li=
nux.org.uk>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
> > "linux-kernel" <linux-kernel@vger.kernel.org>, "Li Guifu" <bluce.ligui=
fu@huawei.com>, "Fang Wei" <fangwei1@huawei.com>,
> > "Pavel Machek" <pavel@denx.de>, "linux-fsdevel" <linux-fsdevel@vger.ke=
rnel.org>, "Andrew Morton"
> > <akpm@linux-foundation.org>, "torvalds" <torvalds@linux-foundation.org=
>
> > Gesendet: Sonntag, 18. August 2019 19:46:21
> > Betreff: Re: [PATCH] erofs: move erofs out of staging
>
> > On Sun, Aug 18, 2019 at 07:06:40PM +0200, Richard Weinberger wrote:
> >> > So holding a file system like EROFS to a higher standard than say,
> >> > ext4, xfs, or btrfs hardly seems fair.
> >>
> >> Nobody claimed that.
> >
> > Pointing out that erofs has issues in this area when Gao Xiang is
> > asking if erofs can be moved out of staging and join the "official
> > clubhouse" of file systems could certainly be reasonable interpreted
> > as such.  Reporting such vulnerablities are a good thing, and
> > hopefully all file system maintainers will welcome them.  Doing them
> > on a e-mail thread about promoting out of erofs is certainly going to
> > lead to inferences of a double standard.
>
> Well, this was not at all my intention.
> erofs raised my attention and instead of wasting a new thread
> I answered here and reported what I found while looking at it.
> That's all.

Thank you very much, EROFS finally has some real concern
after a quite long time. I will do that but I really want
to upstream for 5.4LTS and hope to get your further report.

Thanks,
Gao Xiang

>
> Thanks,
> //richard
