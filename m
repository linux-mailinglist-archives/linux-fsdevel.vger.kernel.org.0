Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3179D918AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfHRSSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 14:18:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:38725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRSSJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566152236;
        bh=olzbdpYcdX1wo7rbrojZaOo8itZUmiQpkIvpjbyhLeU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HMwG3oLdNmJN4LwbI7ogCURJC88T06OH3KBlC5IwNwbTsx8KLJsSSMmjzn67eABHB
         6VxegqXBrcFbQXK6eOdy4S8jrdTjxxARdbzAkdWDg7RkXrFAveo7FIm5D0MXyUEEVg
         zBdc3ZX1L+0XichC43N+idjWxyIwXO2mAGxkuiVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([115.197.242.96]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LuJDv-1iR9G13gHv-011ke0; Sun, 18 Aug 2019 20:17:15 +0200
Date:   Mon, 19 Aug 2019 02:16:55 +0800
From:   Gao Xiang <hsiangkao@gmx.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818174702.GA17633@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:KyuZ/WlcN/RTUTJEyD8sKz+ptXDlsFU1HZE5mU1CXHgB7K5RIaw
 158LdLU1Wf8aLgfTcPtookMI86iKy6/vzRW1tpHjI8n6wMPaK7u1hGJQdU8t23xOliK5I/w
 WEivIkLCTOLT9MafloVCTBsCLAqnByyq59Aoku1gp7+GfZ6flkOhFP5CbdTWv0w7qgNvFS6
 k8vypWLt6/OAKPH5pqBNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MX3f/wK6Ywc=:Oro2x4h6CadPFq+FPfjCv/
 I6Rr49SvHCPwy/w4Oi4ys9TCk+9tdGwcGhu6AcTM24l/vdxq7WAkfxt5QvhFs7Hgb/nGw/ewu
 kYnIjoeR29tj5K32SBJy2T6pg4gDr/3VxN+lOnpgJShaBzraEPb2qlysppfUpJu3Pl/y/Fxjl
 yNe6RcPOGTWZwql7pgfEFprfgP2EKyWSMTmQ/HHgW3+fcIk97zac9/0NAEF0v+QGZc7jprXlZ
 kJ6IeFrb+92NTwW4+Wx53L5h7G78NQAXo0gux4seyey3nzjO3pKJbp4si9Eo4YEwGXrRWC54B
 AmjyEXnpeypiwGjs3euzj8CpFLJip3j0twHo462ObokuCmZjq3UPdYv8MylUJ3X0JzqFNrR0L
 XgP51yJr/LsnUMug7Rrxz9QldKY+5VmAXPoAOKWyGqJRroAj9HrI7uPSCbBXRVEpbVBSCyLxT
 u6DfbHB49Dcd12lVMwHDx7PYU3Ipn4yWr76cPdKErHI+nDL8XY0GOyPuRRwl6RUIob+AOlnRT
 2I4XbUn1F6KnEwp5LAdQfh/T1WBDT+9kPvgxATq/2jjx/Mb+Vm6KFH54cE4fwiCk8LLJ5/8a4
 /zbvOtHDeyBvcJYNM9ZRMIt7lD7MCNRDX7k8ri3QyrysiEV1V9teLgT3394IaP/toVVT9RQep
 jZ66f4NuRKFUBiHYnCiLrPVFAANpOcH50Dk19UPuIDFbtvbCwiaS/+KOoglhrbk5syG/lHCuI
 UQNU8STHtzRIFCStyGWfQ/JcF3tdgXnaTVXOAqwMnr8kxDqlk1gapvcBkVydgDPRDcOXJ69VJ
 urYwA5qMkykGbGo5GInXHkgqLtUnCE1JJfsH13j4LzKmANoyrBywkfhNzzqlC8tvBcevJH3js
 G6vKLJt+ul6hTTxngAEAXv9viptALFMMQHvduab1UOB25dvjayPbL/8VcJPNwtgbEL292kOG2
 91xCJG22O6r+hEQDPyq0aYjJp6O4xVpEqT8ExrgMvXTOr09P+PAHSsoVIyfrGc3tQ8CeePNNH
 ZR2GewzHPsI6GNOMz8UctXI2vzMrQ2bjkvlbCYS2GUCFpvdljdzdrcVwdKLfh/o2T+4mr/buV
 qess+xQKNEjmbvsTrOqb3syi3ZQS5DHl2mBjvbdEVSgn/N4VRVef1bMpg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hch,

On Sun, Aug 18, 2019 at 10:47:02AM -0700, Christoph Hellwig wrote:
> On Sun, Aug 18, 2019 at 10:29:38AM -0700, Eric Biggers wrote:
> > Not sure what you're even disagreeing with, as I *do* expect new files=
ystems to
> > be held to a high standard, and to be written with the assumption that=
 the
> > on-disk data may be corrupted or malicious.  We just can't expect the =
bar to be
> > so high (e.g. no bugs) that it's never been attained by *any* filesyst=
em even
> > after years/decades of active development.  If the developers were car=
eful, the
> > code generally looks robust, and they are willing to address such bugs=
 as they
> > are found, realistically that's as good as we can expect to get...
>
> Well, the impression I got from Richards quick look and the reply to it =
is
> that there is very little attempt to validate the ondisk data structure
> and there is absolutely no priority to do so.  Which is very different
> from there is a bug or two here and there.

As my second reply to Richard, I didn't fuzz all the on-disk fields for ER=
OFS.
and as my reply to Richard / Greg, current EROFS is used on the top of dm-=
verity.

I cannot say how well EROFS will be performed on malformed images (and you=
 can
also find the bug richard pointed out is a miswritten break->continue by m=
yself).

I posted the upstream EROFS post on July 4, 2019 and a month and a half la=
ter,
no one can tell me (yes, thanks for kind people reply me about their sugge=
stion)
what we should do next (you can see these emails, I sent many times) to me=
et
the minimal upstream requirements and rare people can even dip into my cod=
e.

That is all I want to say. I will work on autofuzz these days, and I want =
to
know how to meet your requirements on this (you can tell us your standard,
how well should we do).

OK, you don't reply to my post once, I have no idea how to get your first =
reply.

Thanks,
Gao Xiang

