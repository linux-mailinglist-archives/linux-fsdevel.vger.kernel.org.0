Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A194C44ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 13:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiBYMww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 07:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbiBYMwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:52:49 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06669C4847;
        Fri, 25 Feb 2022 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1645793530;
        bh=9lcoOLsGCXLhkybsvev0q1tU/jL3rCQ5FnCyxRe43og=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Jd/SsLoPixrR02DgY9hWbozzLSPPbGTNJnOW7wDsw/ZrlZX9EduwaxRHuSJO5jDdl
         4GLz8WqWjsUHRFAecNL1seO6geNv2sb8+IbG0dcUyhS+YRqJSCrxsqZTT6t21hNJIg
         qqBYTLJdur5M2gBEV30oIOLZPF68G7Cq+4w2vl4Y=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F1F4F1280D51;
        Fri, 25 Feb 2022 07:52:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id usP77mWu0meA; Fri, 25 Feb 2022 07:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1645793530;
        bh=9lcoOLsGCXLhkybsvev0q1tU/jL3rCQ5FnCyxRe43og=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Jd/SsLoPixrR02DgY9hWbozzLSPPbGTNJnOW7wDsw/ZrlZX9EduwaxRHuSJO5jDdl
         4GLz8WqWjsUHRFAecNL1seO6geNv2sb8+IbG0dcUyhS+YRqJSCrxsqZTT6t21hNJIg
         qqBYTLJdur5M2gBEV30oIOLZPF68G7Cq+4w2vl4Y=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1D461280BA6;
        Fri, 25 Feb 2022 07:52:09 -0500 (EST)
Message-ID: <c97132f444ddb45dcbd4561df0a0c045dbcc2192.camel@HansenPartnership.com>
Subject: Re: [REMINDER] LSF/MM/BPF: 2022: Call for Proposals
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Feb 2022 07:52:08 -0500
In-Reply-To: <YherWymi1E/hP/sS@localhost.localdomain>
References: <YherWymi1E/hP/sS@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-02-24 at 10:59 -0500, Josef Bacik wrote:
> A few updates
> 
> - The COVID related restrictions can be found here 
> 
> 	
> https://events.linuxfoundation.org/lsfmm/attend/health-and-safety/
> 
> - We are working on a virtual component, however it will likely not
> be interactive, likely just a live stream and then an IRC channel to
> ask questions through.

We've been experimenting with hybrid over at plumbers.  Our last
experiment at LSS in Seattle managed to get us a successful interactive
two way A/V stream for a live Q and A using Big Blue Button.  We
collaborated with E3 on this (The standard LF A/V provider for OSS) so
most likely they'll be who you have in Palm Springs.  We were planning
to go for another trial at OSS in Austin, but if you'd like to be our
Guinea Pig, we can put all our infrastructure at your disposal.

Note, your hotel uplink may not support doing this for all four tracks:
we estimate the uplink bandwidth requirement at around 10M per track
dedicated, but we could try it on a single track.

Regards,

James


