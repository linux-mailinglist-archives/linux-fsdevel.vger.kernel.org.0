Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15D660702
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 20:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjAFTTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 14:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAFTSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:18:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D375D04;
        Fri,  6 Jan 2023 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4aICQuKRCBChVLjI5BSEBPzWrSN5ZG0qEZtkt7+/yaY=; b=DEbRBqLaM1y3nOt7XlNB8yj8XI
        5b2zrW3GmtfRXdQ6/I4hudkU/VV/L/E3h9+6zFdWHgFMVAbp65LtnUyAVkm8XkjXKXm5ap2sp+pnH
        RcJx34V6rjTOa5WxugVk7EBX3XiCRkWBlZ05xAvb4D6n8Axb8wsqBZCuO69a89kVGh1KaYS+M3SyJ
        G9orEHVD6S6H40GvDtZ8eWgkhGeuWJeVoEY4Q1h78XzlQrlV4h0J6EVN2469Mje09anHX0iF2+WTe
        oeBBuJsRz5E5Txp+tfKoxKoCSzT1M+bFbV4tAK6C4xA/HlZsTGhJawua6uiIJgipC5OrLoOj6zbmS
        JzU7TAfA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDsEp-00EZ7R-Fh; Fri, 06 Jan 2023 19:18:47 +0000
Date:   Fri, 6 Jan 2023 11:18:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        "Viacheslav A. Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: Re: [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Message-ID: <Y7h0F0w06cNM89hO@bombadil.infradead.org>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 06, 2023 at 11:17:19AM -0800, Viacheslav Dubeyko wrote:
> Hello,
> 
> As far as I can see, I have two topics for discussion.

What's that?

  Luis
