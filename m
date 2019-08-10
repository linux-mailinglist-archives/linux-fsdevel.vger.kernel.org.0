Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9731388787
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 03:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfHJBev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 21:34:51 -0400
Received: from sonic309-26.consmr.mail.ir2.yahoo.com ([77.238.179.84]:38731
        "EHLO sonic309-26.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfHJBev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 21:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1565400888; bh=yFSrzjCe8aeTR1o0wz0qBc2zdxHr9N5uVwJs6zue77k=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=iyHqBKyAz0qExWXmXfna4A1rpa8XQJ20bLWPlqyKQvYiy0L3+s85L962SPZv5GpfVuQM6NkNLmCWt12cbGXzdSsSr2gyWms9MsZaAEryTgWDnzXks2mWe7axAPPzvTtaND+cLCVcCVzTIbIVN5iGsQbCz5CPjEG4NoTX0fQLQ8NqWYIh8zw2vEm2k1+BRT7VBDfEEXeL4sadI4YKEAF1w04v438weDBTNuQwg1W94OzTE0LHw4/PDwRsk+n97swFKUEIAtp4od/344CcJWPG2PGA0FP4ohPJCQK1/F4bXtHvD+mBRzi80cMdC5HFHfMRZp8xjZ9m4NUPVw9TBaqS1A==
X-YMail-OSG: wAm2JtkVM1nbm0UY_M_6G82SqwCjEHIarX.vz.RPSK.dcfOuJpw.1RrnzYnrEdk
 9Sk8.RygKYulvz5UwAD1APJ89scGqfXKSSiafAej2x1LU_CVa4a5kB7Q3CXcmVoQRl_bBsrx8cyg
 bKmKk17XeWimsgKkNE_y9umjARxmXvZ.WRQd7bC_WiK1FNq43uoyEWln.4bx7G9xLNrK7.EgY_8D
 mShuZWxX0w9ldu0eO7_HjcU1P7pbwJd2izTIpmkrrtu4AyrmHqrs2v9jjTBxJzISlQOEO8JuOETy
 48wg3JGIVQP9ptGMnJzXjZsfuPQSS7bS8defnuLikMoElrc9EYgp2FkenTxVGSOgTyPdx45bYkC3
 RXhj906tdB0RqR6Bhyy0MpjlWgV3aJuWreY6_dYhiDEYz6rLEfQhbBzFRJneFf8_oYDl7xaM8JEf
 aZJajOEtMnYxr8O1wa1HhsG4VTPDnaMrFoVxq6DJ7C9IxuPQnMZ87Ypu8A8nDwit3GyW3T336UVl
 4KQIT4csBzgEbmo8UN5HbDvqwYnjiK6Cf6VF0fWYZDi.3Vo2TpKu8GotYU6h5exg2_TRpRIngudU
 D6ZTw_NGy12.z6hy5t5I5fDpYoAJ7hpYZdymaH_bqHS29CZjIc7s8XjgZiS.ZOmCzWTLKmWfkx8d
 Q.Pn7.wqkj6u3Kv_8_yiELrkjUjAGtVtSnwlswJkMEv.SNSnzS0N_HvAHXJ7sRFYrmA589iJQM2a
 t41SRh7yXvAX5GCECjLVgs7ZGrQgvZBGAtR0UC9_t0C09KBST10z45XllpfGm_CWAvoeTQBj1rlE
 5eVxkg6hijx.qknQVhExoRYT6P9GmgNLW3lWV.ATWA35pkcIJP5Qz9Qes5oIRFon2PbqT4LiPzls
 QbS1PwGxRr.cFNDlofp1iLNo9.2OAhKzUC.zykqkgXyRdHLu5MYu9.lvp.EhDyMrFexc1G2_y_7P
 _6VdhngdcH5Cs.CRlS7a.v4bq6h3Z6HQMu3RR_iYCAlhfLxi1vyTrIqn4wCM6xGfkeJKSEFKSSDn
 BmwT5Kb6jDKwPAdDOx0PatuvgQOav.r8Z2P395S_1YSxjLIKbtAB9ujbO_XLZe3DQetT6qPiKwwI
 Xm2Gyr6_jeL6APRKGolvc9AAhU436ZFaMu8MRXV.d5MXoD9FYtNj1lA1xPkn7YvdvU5P64dMbUSl
 PyCrvO72Qyut6wvcouoGVC4uiGkT0BFYB92_96IoG_bUbdT02MQNvUGytBebGwy1YG3QHjA8HL08
 9F6drZHJjWiELBW4py1D3Uy9QXgFbIIVPggoj9Pw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sat, 10 Aug 2019 01:34:48 +0000
Received: by smtp423.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 238703fa3bfcf0001ed6741761e647ee;
          Sat, 10 Aug 2019 01:34:46 +0000 (UTC)
Date:   Sat, 10 Aug 2019 09:34:38 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190810013432.GB27374@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
 <20190809204517.GR5482@bombadil.infradead.org>
 <20190809234554.GA25734@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190810003135.GF100971@gmail.com>
 <20190810005038.GG100971@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810005038.GG100971@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:50:40PM -0700, Eric Biggers wrote:
> On Fri, Aug 09, 2019 at 05:31:35PM -0700, Eric Biggers wrote:
> > On Sat, Aug 10, 2019 at 07:45:59AM +0800, Gao Xiang wrote:
> > > Hi Willy,
> > > 
> > > On Fri, Aug 09, 2019 at 01:45:17PM -0700, Matthew Wilcox wrote:
> > > > On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > > > > On Thu, Aug 08, 2019 at 12:26:42PM +0800, Gao Xiang wrote:
> > > > > >     1. decrypt->verity->decompress
> > > > > > 
> > > > > >     2. verity->decompress->decrypt
> > > > > > 
> > > > > >     3. decompress->decrypt->verity
> > > > > > 
> > > > > >    1. and 2. could cause less computation since it processes
> > > > > >    compressed data, and the security is good enough since
> > > > > >    the behavior of decompression algorithm is deterministic.
> > > > > >    3 could cause more computation.
> > > > > > 
> > > > > > All I want to say is the post process is so complicated since we have
> > > > > > many selection if encryption, decompression, verification are all involved.
> > > > > > 
> > > > > > Maybe introduce a core subset to IOMAP is better for long-term
> > > > > > maintainment and better performance. And we should consider it
> > > > > > more carefully.
> > > > > > 
> > > > > 
> > > > > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> > > > 
> > > > That used to be true, but a paper in 2004 suggested it's not true.
> > > > Further work in this space in 2009 based on block ciphers:
> > > > https://arxiv.org/pdf/1009.1759
> > > > 
> > > > It looks like it'd be computationally expensive to do, but feasible.
> > > 
> > > Yes, maybe someone cares where encrypt is at due to their system design.
> > > 
> > > and I thought over these days, I have to repeat my thought of verity
> > > again :( the meaningful order ought to be "decrypt->verity->decompress"
> > > rather than "decrypt->decompress->verity" if compression is involved.
> > > 
> > > since most (de)compress algorithms are complex enough (allocate memory and
> > > do a lot of unsafe stuffes such as wildcopy) and even maybe unsafe by its
> > > design, we cannot do verity in the end for security consideration thus
> > > the whole system can be vulnerable by this order from malformed on-disk
> > > data. In other words, we need to verify on compressed data.
> > > 
> > > Fsverity is fine for me since most decrypt algorithms is stable and reliable
> > > and no compression by its design, but if some decrypt software algorithms is
> > > complicated enough, I'd suggest "verity->decrypt" as well to some extent.
> > > 
> > > Considering transformation "A->B->C->D->....->verity", if any of "A->B->C
> > > ->D->..." is attacked by the malformed on-disk data... It would crash or
> > > even root the whole operating system.
> > > 
> > > All in all, we have to verify data earlier in order to get trusted data
> > > for later complex transformation chains.
> > > 
> > > The performance benefit I described in my previous email, it seems no need
> > > to say again... please take them into consideration and I think it's no
> > > easy to get a unique generic post-read order for all real systems.
> > > 
> > 
> > While it would be nice to protect against filesystem bugs, it's not the point of
> > fs-verity.  fs-verity is about authenticating the contents the *user* sees, so
> > that e.g. a file can be distributed to many computers and it can be
> > authenticated regardless of exactly what other filesystem features were used
> > when it was stored on disk.  Different computers may use:
> > 
> > - Different filesystems
> > - Different compression algorithms (or no compression)
> > - Different compression strengths, even with same algorithm
> > - Different divisions of the file into compression units
> > - Different encryption algorithms (or no encryption)
> > - Different encryption keys, even with same algorithm
> > - Different encryption nonces, even with same key
> > 
> > All those change the on-disk data; only the user-visible data stays the same.
> > 
> > Bugs in filesystems may also be exploited regardless of fs-verity, as the
> > attacker (able to manipulate on-disk image) can create a malicious file without
> > fs-verity enabled, somewhere else on the filesystem.
> > 
> > If you actually want to authenticate the full filesystem image, you need to use
> > dm-verity, which is designed for that.
> > 
> 
> Also keep in mind that ideally the encryption layer would do authenticated
> encryption, so that during decrypt->decompress->verity the blocks only get past
> the decrypt step if they're authentically from someone with the encryption key.
> That's currently missing from fscrypt for practical reasons (read/write
> per-block metadata is really hard on most filesystems), but in an ideal world it
> would be there.  The fs-verity step is conceptually different, but it seems it's
> being conflated with this missing step.

Yes, but encryption could be not enabled mandatorily for all the post-read data,
and not all encrypt algorithms are authenticated encryption...blah-blah-blah...

I want to stop here :) and I think it depends on real requirements, and I don't
want the geneeric post-read process is too limited by specfic chains....

Thanks,
Gao XIang

> 
> - Eric
