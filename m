Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAB890D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 11:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfHKJA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 05:00:27 -0400
Received: from sonic304-21.consmr.mail.ir2.yahoo.com ([77.238.179.146]:33638
        "EHLO sonic304-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbfHKJA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 05:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1565514024; bh=N5SHhFaXP33ZX3WyeMFCah1u1u3siPkQQGYR/97pzW8=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=EWEhxG2tbM1E8FtuCNlhmfnazoH2jDzwcK8sLMZdGgChMKyhIR/rv6AHRKU3c8+zUChDMBnsTfqkn+pz6bTjhNf90fFeRI7P8sm0hWMkjlS0SIxt/KoaPXIh4wyimYhwf8YH/0DdUDlkbQc4IKWbNwWZAI4GRNuvS76B3sDZv2ZC7kQt4cy6Fc1AYRhIhQnleTNldJTxPkosEdaBbfgHl6Z6l+ssdZWL27hqr9aeaOabarhsus05b4XVdwUmHCXzI7xuczjMaSLKem0yBlnEl+KLXlqzg3Wnbn59YVvMjWWnnmqv5Vcn4Cx/wNDX2/BxHZfGcN/pwX/5HuuB5x8bUg==
X-YMail-OSG: chqe9lUVM1mhODpEzJJQ9YTcmSaDMJQe1it5CrKYqq9UyJbsVf._5m5rCiWyzml
 GyX3uTHg17MBwo.OIbjF1THufnBUuGj_k9L2Wncb05KYrGRLQBhYy7wLlF8BL94yNzyHtZ1Dih8O
 PLtaKz7Y8SVACZvFzuMdEW6J8N.S_t_QyeEJrYzZ.1RcXC9m.9p0mEBJH5SjxXNN9C6CIbKXhjSV
 7_LQoIafzDrpc.SbR_ilZayJln6vQcz1ngFMWB_E6Y9sb5p56BPZ5fZUk17olIDB.LbwzB2p9n1H
 t7cVdvN_wVbzvEyMkBbzbH4GdA1i3HOPX_5qnsOiTSYzUDAKb69GKw9BBYMskB3eFA_FlZpk.7td
 d3NGvfiw3tZA3ePB5myQn1UHwfbhzynZV5Af8hc4fEhBLsLb.cGMTX_0zjqC1.sYi6P_LWsBp.I3
 tWcx79MzYRmuP_YyXcrNwZdCDEp_MBUK_PhRYXECDie6QAmkyLaGa6Y_IlesDyltlm8TtPqIIG47
 RI2ZVpSAJgoiY31VpQDqm9ksOp85GYCZ5QZkgu5skIyvEOgUNokx.8IivSCp.45ydvJi4XWz.553
 jFRV3izU_4pvSPKS1IJ1zIaKdh6eqr30Qb8H7AlLZFN.MyKh11AayvwfK0RJLMGFM0B.cDBQvq3D
 V7.uLsi1_o9pv3zahD8dRxYI3HBA9TLQQDUR1YNZxITwr6sWFMggByuE35zlQ2F4ESCvEIHcY4QY
 _VtNzVL_cMXFSdCgA2tOFc8ITuRvzwEbAHFuegl_4yv6wIZj8DSkXuBWbRlEAzCKsXFqE5ikfhRm
 3i.R5iIwDRBP1SYN9ZbSg6Cd4WFOA_a7aVTdJtyygHML46tiYmk3v_BqNuTQE7ATWb19OGe01eJU
 kzG4FP9RCN3oqMHPIQ4pVlbmm035butIwTOCXgcu_qbF5cdTPvHhlqouEIZb3De9BlSlnsm3WQwS
 ZgeVF.ugeCySmG7V8aoP8Pyc.q7GHT2k71ipnvk4r99ozpKfaYfHq3FvCLlpv6NCnXzOpKd1DUET
 t1iWF6wsYNbIIbDRzOILmjEGV4Q3R9D4UNgnqiiY_CdqLZiQYgePhPCEN7pWQWjLvzZH.AAv1vQN
 c6hmZ0RjhfvUm_VhXMDRUzCI6ZGaZtMFDIEom6yVCry4hbatdBNIP.95T.3fLB.8B6.2UK6fa89Y
 bunM.o63yOqqfRiM17jhI.v5dXT_pH2KVGEpqxPe6GuB1vWz_aFblpMiYah0ZneqQ_vmdl7PnzKF
 VPFnTtRFL9zYB2ydmxzGwAdBjZw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sun, 11 Aug 2019 09:00:24 +0000
Received: by smtp413.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 63529cb0b651f479fd1427ad5b2f4796;
          Sun, 11 Aug 2019 09:00:20 +0000 (UTC)
Date:   Sun, 11 Aug 2019 17:00:01 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190811085957.GA30612@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com>
 <20190811074348.GA13485@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811074348.GA13485@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi hch,

On Sun, Aug 11, 2019 at 12:43:48AM -0700, Christoph Hellwig wrote:
> On Sun, Aug 11, 2019 at 09:40:05AM +0200, Greg Kroah-Hartman wrote:
> > > Since I do not see the lack of reviewing capacity problem get solved
> > > anytime soon, I was wondering if you are ok with putting the code
> > > in drivers/staging/vboxsf for now, until someone can review it and ack it
> > > for moving over to sf/vboxsf ?
> > 
> > I have no objection to that if the vfs developers do not mind.
> 
> We had really bad experiences with fs code in staging.  I think it is
> a bad idea that should not be repeated.

I had no intention to join this topic. However, out of curiousty, I'd like
to hear your opinion about EROFS. I personally think that's not so bad?

EROFS is designed for the specific goal, and it is proven that it has much
better performance than other compress filesystems even uncompressed
filesystems with proper hardware combinations. And we have an active team
(with paid job) and some other companies (primary in Android scope) have
contacted with me in private about using this as well.

We are doing our best efforts on moving out of staging, and I personally
think the code seems not bad... Can you give me some more hints in advance?

Thank you very much,
Gao Xiang

