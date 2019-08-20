Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBD996715
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfHTRHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 13:07:54 -0400
Received: from sonic315-54.consmr.mail.gq1.yahoo.com ([98.137.65.30]:35194
        "EHLO sonic315-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729639AbfHTRHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566320872; bh=uMe6Ni541x/tMuArILRS79nFePqtfX01dZSfF3dkEYU=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=bD9GkUx5D1V4K/A+hD22iVhlchUOmHYjcVfa9nsuvVDxHnJGuJv/BEPmWYgObrCCvLHWLOnWeJTwLQbcobTQ/wddptZDuS8GsJKtQVNUwP7gbVMh4ygcRezjjQRiTkjfJB0vLDLlJSjBLjYx6pvBenm6S+hRBy0uRJ3XdYau8TsntER2hfMlfdd5MJTXDQ0BprTgmNdx0UL/VJ1JWCn4KWBJ7w6jnOmxOrrBmljBRXtloRvMzT63n3hrFJhsdZI+JTP27v7ct/aKA3PPdgJGeG5iyTjRsArsoJVM+YE66PKo9+ILAj/bUYl2G39OmyfKotrt02ZMl6MJQwvt/CMfQg==
X-YMail-OSG: Y8Hmm7cVM1k.LYOMGpeBdzN2Uatlbr1IX9lewWRlqVGPFcvxoQSHHEAMk.NZwTL
 k4nnNO91Sbr0TSzU1Tzb9buMyZkhcNXHHmUowo8Au0IhVQwuGiIJC6I.JfhPLckFGR0pC_DtSO_c
 QcwnvTMqofVabosbxshdC3.RI6vQPgr0R.AADM_abVDl78X3Bqy0_NK8bmz92clhaTzp2aQ6N1yb
 13NNNSyauSpZDak0oTQqaJ3kRIO4rxvlPu7HXNRSikq1bRsk_ky.9duLEtliDSBDP6YmKyfmX0_P
 nQ1ajrvaXdiXkWYvCgJVVTnybZgog7tkyaA4t3610EsvOcMbvVmo5AR56TjIOH4Yy2rDQw.zzG1x
 iw3rXQqh1EwPDzDXz6O6SRRg_gE5GYVG7BdcK054DF8sFi0B6itcmNFKD89hppET7tMY_nkHZJQD
 1XWx2zzTRevbYvwShd28OxRGVZS1cNQCQehKcV68Hfh5..2ow7vwQEHICwLhKXceK0kzMK_fHkrI
 STvbwOs3mf2y_sUAncfpKcA3vtWREf5UivqwhrBA4YS2BxFXmaObGl1tXO86c_GKLuUwf0kNQCmM
 u5ILfnHAN60C7GsNV__8NSX5yqH3vYlC2i.qOsRVRO5uvsyS6OX4VVovbA5yLXHetuAfcnvBmSFT
 DvGhR6cml5yVXzmzWjZLnaGAWh_bE5A6yEAD7Dm_u5.rYlj4sqvjzpdr1mbTPsfMuiQ08vqFBkSD
 nWLvDwy62xnGebylj64Gn.M_JAcUEacqxogv8Mvf6oPBllx7kIR5TYtplg7.0KugMTc33QKGuvJb
 JaF53yehXvKJlgRzKanZOwhAB_eCX0yDXlVOTsLxsD0q4CM1PWzAKWCO6Rh6SPsClLF8KKIF3eLt
 0PRtwX6FggsM5eL4iAqnNqvIrm.eojNybSnao8WJvd7_BI0oAQxJ3u2xNY5Y8Cc1T9ZmAtRZDRQm
 oUeRocJWdRthyDzkynb10lpPnT_lSOWWfzndkfyed01Gb4r7YV9CUajWgTBm0gaLMjk5eJEQiBzl
 rqu9zn.YWrRETYxkIYQQWS9z.Ual_KwuTUwHUXOIJnH.Uc6VB2y5NoLzhBYM1fVqDWr3_7fSHzH1
 HXROqzGjsMRlP9p0Gs2FVD3Z_qIiDYQs3_jqllGN1cpuuuTEYu3SjW4lxtRgwZcWB.a8ZY5gmQqA
 TOeIDAP5DSJNEXqbCCOSQq5LMvIK.7QQD.rIF4ylq1u_iVDm.O.CZF.pxyztQft8oWYItnv13Q69
 rrCg92XTZ4eWNT4UO86Y2AvAgDaarEM.O
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 20 Aug 2019 17:07:52 +0000
Received: by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 338a11c40dd48f03e306532b9b1c5f14;
          Tue, 20 Aug 2019 17:07:51 +0000 (UTC)
Date:   Wed, 21 Aug 2019 01:07:43 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Chandan Rajendra <chandan@linux.ibm.com>, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, chandanrmail@gmail.com,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting file data
Message-ID: <20190820170738.GA8402@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
 <20190816061804.14840-6-chandan@linux.ibm.com>
 <1652707.8YmLLlegLt@localhost.localdomain>
 <20190820051236.GE159846@architecture4>
 <20190820162510.GC10232@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820162510.GC10232@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On Tue, Aug 20, 2019 at 12:25:10PM -0400, Theodore Y. Ts'o wrote:
> On Tue, Aug 20, 2019 at 01:12:36PM +0800, Gao Xiang wrote:
> > Add a word, I have some little concern about post read procession order
> > a bit as I mentioned before, because I'd like to move common EROFS
> > decompression code out in the future as well for other fses to use
> > after we think it's mature enough.
> > 
> > It seems the current code mainly addresses eliminating duplicated code,
> > therefore I have no idea about that...
> 
> Actually, we should chat.  I was actually thinking about "borrowing"
> code from erofs to provide ext4-specific compression.  I was really
> impressed with the efficiency goals in the erofs design[1] when I
> reviewed the Usenix ATC paper, and as the saying goes, the best
> artists know how to steal from the best.  :-)
> 
> [1] https://www.usenix.org/conference/atc19/presentation/gao

I also guessed it's you reviewed our work as well from some written words :)
(even though it's analymous...) and I personally think there are some
useful stuffs in our EROFS effort.

> 
> My original specific thinking was to do code reuse by copy and paste,
> simply because it was simpler, and I have limited time to work on it.
> But if you are interested in making the erofs pipeline reusable by
> other file systems, and have the time to do the necessary code
> refactoring, I'd love to work with you on that.

Yes, I have interest in making the erofs pipeline for generic fses.
Now I'm still investigating sequential read on very high speed NVME
(like SAMSUNG 970pro, one thread seq read >3GB/s), it seems it still
has some optimization space.

And then I will do that work for generic fses as well... (but the first
thing I want to do is getting erofs out of staging, as Greg said [1])

Metadata should be designed for each fs like ext4, but maybe not flexible
and compacted as EROFS, therefore it could be some extra metadata
overhead than EROFS.

[1] https://lore.kernel.org/lkml/20190618064523.GA6015@kroah.com/

> 
> It should be noted that the f2fs developers have been working on their
> own compression scheme that was going to be f2fs-specific, unlike the
> file system generic approach used with fsverity and fscrypt.
> 
> My expectation is that we will need to modify the read pipeling code
> to support compression.  That's true whether we are looking at the
> existing file system-specific code used by ext4 and f2fs or in some
> combined work such as what Chandan has proposed.

I think either form is fine with me. :) But it seems that is some minor
which tree we will work on (Maybe Chandan's work will be merged then).

The first thing I need to do is to tidy up the code, and making it more
general, and then it will be very easy for fses to integrate :)

Thanks,
Gao Xiang


> 
> Cheers,
> 
> 					- Ted
