Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44776B2CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjHALMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjHALMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:12:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A525589;
        Tue,  1 Aug 2023 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHFkwtImJCHfadA4mLPZ+idHA2aPqsh4tm9M6CpV/bU=; b=sZiMVB0MVw0u51eoqY/IxhUM/Q
        YgFcLXdOn4/G94rFB2RfViIzC04WFRIyEPXWem8dgzaVyMIvEw8H8L9nxmUrZ6TzOgfsAwztSrQAl
        S9U5Wn/8XXPay2YJZ4jBqMxeP8VkLhSBqVjmJTXOm1tIjmZpEv/yJb++EmngGDrMYcLDjcMZdJRci
        T93q5ixvkUylvP/7zZPR9WQfeSsv4zxUimUHNaJZ9YJRuepWZW0W8avQnLorewXhC4m4l4DU2mzQU
        WufGPkAahNLck76YVTRa60ZzN32ElItL0qcLDOfyUIW4mK5plM/FA5SGQ+imeh6BxAP/4WOzCBebd
        +u1RRUzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQnDi-0023Tl-0T;
        Tue, 01 Aug 2023 11:07:18 +0000
Date:   Tue, 1 Aug 2023 04:07:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Harry Pan <harry.pan@intel.com>, linux-pm@vger.kernel.org
Subject: Re: ksys_sync_helper
Message-ID: <ZMjnZhbKbNMmcUPN@infradead.org>
References: <ZMdgxYPPRYFipu1e@infradead.org>
 <e1aef4d4-b6fb-46ca-f11b-08b3e5eea27d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1aef4d4-b6fb-46ca-f11b-08b3e5eea27d@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 08:27:17PM +0200, Wysocki, Rafael J wrote:
> 
> OK, I'll remember about this.
> 
> 
> > With this
> > and commit d5ea093eebf022e now we end up with a random driver (amdgpu)
> > syncing all file systems for absolutely no good reason.
> 
> Sorry about that.
> 
> The problematic commit should still revert more or less cleanly, so please
> do that if that's what you need.

We'd still need to remove abuse in amdgpu first, though.

