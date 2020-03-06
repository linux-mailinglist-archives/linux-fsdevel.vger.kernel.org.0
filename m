Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7417C66B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 20:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCFTls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 14:41:48 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58338 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbgCFTlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:41:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 240FC8EE11D;
        Fri,  6 Mar 2020 11:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583523707;
        bh=QyH0EDJ1FUP6Cg70Ajo5UwLog6IJKhxqIqwcvgHKFno=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ggY4uvNcRhPuU2n6fZvD3i2Sjj2ROXVGWaKDMw26Qa4G1T1BY6lBdKV5NYvynPde4
         CWtnCQanOW0yynZVXEMPURDEghbUCzIBZ6QiAZVRtYlDRn3rGK8kRt5Pco2QaQ+oQP
         osLlnOSzWdRJHRBGRsgVoBex+rR7JtbkS2weLoSw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S_hz0NBx31Vr; Fri,  6 Mar 2020 11:41:46 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 559378EE0F8;
        Fri,  6 Mar 2020 11:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583523706;
        bh=QyH0EDJ1FUP6Cg70Ajo5UwLog6IJKhxqIqwcvgHKFno=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X2fDg85eJgE/fXmSmsMwLysLAKUTat/D9UP7xUPCwlbBYE/H18bd2pBu4e8TKSwzI
         VsOJSCtAb25f3NDpDas4JghvIp8o2s0nqKA0BO+FDpSEBU6uc5ZBEjr6eo0A78NOg2
         NMcvK9HZQBzURcSGWlaGWAdUIRalj5VH/mfp0Yro=
Message-ID: <1583523705.3653.94.camel@HansenPartnership.com>
Subject: Re: [LSFMMBPF TOPIC] long live LFSMMBPF
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Date:   Fri, 06 Mar 2020 11:41:45 -0800
In-Reply-To: <76B62C4B-6ECB-482B-BF7D-95F42E43E7EB@fb.com>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
         <76B62C4B-6ECB-482B-BF7D-95F42E43E7EB@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-03-06 at 14:27 -0500, Chris Mason wrote:
> On 6 Mar 2020, at 9:35, Josef Bacik wrote:
[...]
> > 4) Planning becomes much simpler.  I've organized miniconf's at 
> > plumbers before, it is far simpler than LSFMMBPF.  You only have
> > to worry about one thing, is this presentation useful.  I no longer
> > have to worry about am I inviting the right people, do we have
> > enough money to cover the space.  Is there enough space for
> > everybody?  Etc.
> 
> We’ve talked about working closely with KS, Plumbers and the 
> Linuxfoundation to make a big picture map of the content and
> frequency  for these confs.

And, lest anyone think we all operate in isolation, we do get together
periodically to discuss venues, selection and combination.  The last
big in-person meeting on this topic was at Plumbers in Vancouver in
2019, where we had Plumbers, KS/MS, LSF/MM and the LF conference people
all represented.

>   I’m sure Angela is having a busy few weeks, but lets work with her
> to schedule this and talk it through.  OSS is a good fit  in terms of
> being flexible enough to fit us in, hopefully we can make  that work.

And, for everyone who gave us feedback in the Plumbers surveys that co-
locating with a big conference is *not* what you want because of
various problems like hallway track disruptions due to other conference
traffic and simply the difficulty of finding people, the current model
under consideration is one conference organization (the LF) but two
separate venues, sort of like OpenStack used to do for their big
conference and design summit to minimize disruption and increase
developer focus.

James

