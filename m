Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD06E1C21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 08:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDNGAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 02:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDNGAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:00:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DAB272B;
        Thu, 13 Apr 2023 23:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rRmy9zG4Ayyodd6oF4M8UDxCsBw3B4r1tYFNpPeo34M=; b=nhCENC5QpfgTZWRFh5sSALj5uC
        ymHpkqNYw4lfjcV3HLM4Oaty7RW/7w2UrXTgUNwozvfLiae7mhoME+vG7sPY27Zfuj/eGMYSwPwRN
        OZkulFxxXyzFLpbHRAMlCZym5DIpPVTVekOUy/0oVr06GgwtmDjo5VOfXuPH5UnS6j1CcILxii57O
        uxl6XOjG6uMQodan4nAEpncm3hGotdu+KY/iVPuYn95NmQlo8wAZOfYjLfJAVucGJM2NVDZ9FXD3c
        JPQLbQV7rHuxktYn1KI61kQPUq3mhqRXlj5smvdt7WD5M2oVAqnqcZiVTH1yf0of/PWvK+JEFph0A
        KlLTUv6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnCTm-008QGj-0A;
        Fri, 14 Apr 2023 06:00:14 +0000
Date:   Thu, 13 Apr 2023 23:00:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 07/10] ext2: Add direct-io trace points
Message-ID: <ZDjr7tVpeOWaW44D@infradead.org>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <4487ba6fc44e37903a81ddf55a24a865ed9255e2.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4487ba6fc44e37903a81ddf55a24a865ed9255e2.1681365596.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So why do you add tracepoints in ext2 in addition to iomap?
