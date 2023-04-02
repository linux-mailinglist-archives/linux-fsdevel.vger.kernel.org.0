Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9724C6D39CA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Apr 2023 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjDBSXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Apr 2023 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDBSXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:23:18 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E35BAD;
        Sun,  2 Apr 2023 11:23:16 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id D13E7C009; Sun,  2 Apr 2023 20:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1680459792; bh=7BxS2xXT1chsYm3tVDETr/9nBuiwdQJK5hypDU99THI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ESiUcIjaVjFbuzagVRTMP0/Qms1EKNYqClc+Kfw+fkoRxhKsRysK4qlPIfOQrgmQ
         kK0nJyY8Fplqkjl9ChBl/7J1OOsfu0CYWya/pveV7CAzCTORtu2AhL8ARjCVBKPRrF
         qp4IJjZpkIcmmu41CQ34rm+KJlMeSFB9dzo2ym6pCeq3I4Fj5xEf6dRUrHb3/cEaLR
         UtLJBjT9LN6uRi7+Dfk+EWBuf7rxH+2dN0kYDxFRnRQ2+AQHdctqoS1QRi7xyAo1Va
         fPmIC/IPK0gDT0Nz6rdOhdkk6PqH9HD4uQi6bvcKjUEq38F/4SJEO6qn4wV4RFei9S
         ySJpFYIReFV+Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from odin (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 4DCFEC009;
        Sun,  2 Apr 2023 20:23:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1680459792; bh=7BxS2xXT1chsYm3tVDETr/9nBuiwdQJK5hypDU99THI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ESiUcIjaVjFbuzagVRTMP0/Qms1EKNYqClc+Kfw+fkoRxhKsRysK4qlPIfOQrgmQ
         kK0nJyY8Fplqkjl9ChBl/7J1OOsfu0CYWya/pveV7CAzCTORtu2AhL8ARjCVBKPRrF
         qp4IJjZpkIcmmu41CQ34rm+KJlMeSFB9dzo2ym6pCeq3I4Fj5xEf6dRUrHb3/cEaLR
         UtLJBjT9LN6uRi7+Dfk+EWBuf7rxH+2dN0kYDxFRnRQ2+AQHdctqoS1QRi7xyAo1Va
         fPmIC/IPK0gDT0Nz6rdOhdkk6PqH9HD4uQi6bvcKjUEq38F/4SJEO6qn4wV4RFei9S
         ySJpFYIReFV+Q==
Received: from localhost (odin [local])
        by odin (OpenSMTPD) with ESMTPA id 4020d9b3;
        Sun, 2 Apr 2023 18:23:07 +0000 (UTC)
Date:   Mon, 3 Apr 2023 03:22:52 +0900
From:   asmadeus@codewreck.org
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] fs/9p: Add new options to Documentation
Message-ID: <ZCnH/HRprV13ugHc@codewreck.org>
References: <ZCEIEKC0s/MFReT0@7e9e31583646>
 <3443961.DhAEVoPbTG@silver>
 <CAFkjPT=j1esw=q-w5KTyHKDZ42BEKCERy-56TiP+Z7tdC=y05w@mail.gmail.com>
 <5898218.pUKYPoVZaQ@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5898218.pUKYPoVZaQ@silver>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Schoenebeck wrote on Sun, Apr 02, 2023 at 04:07:51PM +0200:
> > So, mapping of existing (deprecated) legacy modes:
> > - none (obvious) write_policy=writethrough
> > - *readahead -> cache=file cache_validate_open write_policy=writethrough
> > - mmap -> cache=file cache_validate=open write_policy=writeback
> 
> Mmm, why is that "file"? To me "file" sounds like any access to files is
> cached, whereas cache=mmap just uses the cache if mmap() was called, not for
> any other file access.

The semantics are slightly different but I don't think anyone would
mind; mmap was introduced as a way of having minimal caching but file
caching + /sys/class/bdi/9p*/max_bytes to 0 should be almost identical
once we've made sure our cache code sends bigger than 4k writes at a
time (I *think* that's still a problem and there was netfs work in the
ways, but you'd have noticed?)

--
Dominique
