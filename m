Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8461670FD61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 20:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjEXSBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEXSBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 14:01:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D72D3;
        Wed, 24 May 2023 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5M781RqfVLpQpdHFeNAj7b3kW/gkEokVEHe2kPAGP2Y=; b=0cKEljTmCeyD3iZP48msGV+D1u
        BE8+IexiKKCJuchTPPyw6jQRIKJXZDYauNqnluWo25LM+TLuBdZg/+kexZC4PS1etRJ2J8IZ3mSvM
        h8AIO1mN9H3QtbCdkwrBeXBKuxUfVEGPoLk63BO+06j/2vYP0TXS4XPeekJpn/vOYzbg5BEaJ0OgJ
        BEdsKm1Uf/HYB0++1doXeTRmV+K75oE33TmpBAkdywXNILy1iuu5gLeYAvC8HKabSxP3QAMy6e/jj
        WKmob5WSVaXChmvFwzjkki0rzmboNkJIZ/Yt0RGsUy/lKQx9pHbsLvOoKPw6x9kuPvNEELVFpLdAm
        Q6Jb0YrQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1snW-00EIx3-3A;
        Wed, 24 May 2023 18:01:18 +0000
Date:   Wed, 24 May 2023 11:01:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Joel Granados <j.granados@samsung.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [sysctl] 7eec88986d:
 sysctl_table_check_failed
Message-ID: <ZG5Q7uBYGjbx4TuI@bombadil.infradead.org>
References: <202305241701.115a6cf4-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305241701.115a6cf4-yujie.liu@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 01:55:45AM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "sysctl_table_check_failed" on:
> 
> commit: 7eec88986dce2d85012fbe516def7a2d7d77735c ("sysctl: Refactor base paths registrations")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Fixed by 2f5edd03ca0d7221a88236b344b84f3fc301b1e3 ("sysctl: Refactor base paths registrations"

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next&id=2f5edd03ca0d7221a88236b344b84f3fc301b1e3

  Luis
