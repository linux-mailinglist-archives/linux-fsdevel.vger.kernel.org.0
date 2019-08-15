Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3268F189
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfHOREh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 13:04:37 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com ([77.238.176.99]:33020
        "EHLO sonic301-22.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731185AbfHOREg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1565888674; bh=B1CDKmFfj6aDeTiNOiZadWEgT+fWeNQZxcrgAnVsmOs=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=HDOdOuuayJtJ4At+QPaPyvRwQCfBsUapF49QasrPrPcoc252mv8LHcNr7nXZZpsa4R/w0rw4WA4xIStpwqmQ40wDlNFvzHHNZpw/8DEMsR2eGPp215VYPIAXK5Z8mmaQI43ltmJzM3xplwtyYqILGlUUpBiM2wAy0OtqGuPUNGehJCt4l2PzMxkrzGRlkYXb5oyoM2RnGH1ZrYlW3LBYizvW/hsaVNw+Mc6BEHtoQhex/oFj+i1DsDvGpxV3NfqFWwKHn7RAiEUl+sB45lz6xMp7Oht9uQNNmVeqauMY0wBuFuUMwdbMS0Ypkwwpnh6nFwe7XPVO6VMktbruGsb0rA==
X-YMail-OSG: UCM0UGEVM1k.ECZKTxS2OqaNxzGHhhZ.pF6bQgH1V5pop2SUDTzFWfBv_5CJXjN
 lmzvdcgsctqscHstS.D3ySu2diMWMVLd1NlS_.QLBfWHJgiZJNUUORUdNzd_1JBEHhl23GXEI9Cr
 SkA.ME94KDhq3JYnKqfxE3lBqx1qsUoxTDPcsaK7CSV9uXRuC_rVeJWQGHFrLSxBUMlfKTCwLK1Q
 SRwutEVv7UDXOJfgMG4dfSMV8ocaxYvcBM__Q2ClXC6IYJVrJ4YY.flrgyQVVBvoCL7eNBwLxq..
 E_cKvKeO5.MMCvhwZl.6UTiEJwVPemSOCL9d9MpkZyzrjgsHgpLwmbmm4TZE9yC7ZV5IgDV.cfqj
 6yNGkLoZdle_xiEedxjALL37oIp1kh0B0AnA.rfKPdq.uwJVIgTQW3DfVqlf6iKhB6uy5RFkNXRD
 IlR3ZLEMzYftGCwgQzomL.99B5RdayKOfbP7ZfTyQFsQfXaxma1dQwsDzs1eJW7MlH6NvdnIH6v0
 bl_66yAONv0NOGPRWVKJ2AUkGWWM5HBJDnqQZDhfj2vYWjXijuZiUOYh218tDbWkiNOWjMiXRv5w
 Nco0gD6FUD9TZNJowGp.fNnHLIWQcSoJvyGArd42Ffch7Cx6LrmtIkLSBB96xZiAkDsIdZSQCSc6
 dkew2LYcnzCsBKEhae3KwsT1sQGkuPPJHLa0xazi.g4qhenO1N9UemS55UuwOF0X0QuNam0ArZVe
 B33q0v8eDbA3TkRAhrspGG0NCt8Bw54BjY6.zQd4f7PTFB76.fPLd7UUF5LElwll.bgQ7L6fQplJ
 OkBMAzSujJwqSD6EqYHLE0a5NAsbBhO9VISE_me1hH17bSBl7PczHs72rzmHz7y4Ct6M2jZQpSB6
 tHWM.i.sGQksU1s5UcKLX3g9nFurGU02ehnJtJH_DkBr5b75yV8_Kwlosn0Z.4gGb_AUmPY7CvEN
 MUT_Hs1lwsxl9CamXd_8IYJNCuCjCl439CIsZhETFo1_kc3Ym_ysi0jzwtdzhSf3nvYG65HHjczN
 02AhHEXoNChDFLMmb35Zbz597Zwjb_yN.f8l32.wP_8j2dFd61e9qAPZ9feIO1mnYh8jMP9.8gtC
 Iuhc0t6IPpsXPvLhXu6mLkFuALJhX9VT7QJomXTsg2k0BTOmxpOPmc4KbWEtgl.qKtaeqJBXu.Lh
 U2PQwdOgTlMhmhp4bmv2LeLI40LC8k3GvxgXsEOLJJHFKc4uiqRbwrVnkKviQ..NTaE3gXl6T8yc
 dtaTogao_6wD2HNBCXC2GNMHbgcUmop8L_06agRcMtFBrCsI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Thu, 15 Aug 2019 17:04:34 +0000
Received: by smtp432.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ed96a2e86c060211f0b97b71e44301c9;
          Thu, 15 Aug 2019 17:04:32 +0000 (UTC)
Date:   Fri, 16 Aug 2019 01:04:14 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Richard Weinberger <richard@nod.at>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v8 00/24] erofs: promote erofs from staging v8
Message-ID: <20190815170409.GB4958@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815090603.GD4938@kroah.com>
 <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On Thu, Aug 15, 2019 at 09:18:12AM -0700, Linus Torvalds wrote:
> On Thu, Aug 15, 2019 at 2:06 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > I know everyone is busy, but given the length this has been in staging,
> > and the constant good progress toward cleaning it all up that has been
> > happening, I want to get this moved out of staging soon.
> 
> Since it doesn't touch anything outside of its own filesystem, I have
> no real objections. We've never had huge problems with odd
> filesystems.
> 
> I read through the patches to look for syntactic stuff (ie very much
> *not* looking at actual code working or not), and had only one
> comment. It's not critical, but it would be nice to do as part of (or
> before) the "get it out of staging".

Thanks for your kind reply!

OK, I will submit a patch later to address your comment and
a pending formal moving patch with a suggestion by Stephen earlier
for Greg as well.

Thanks,
Gao Xiang

> 
>                  Linus
