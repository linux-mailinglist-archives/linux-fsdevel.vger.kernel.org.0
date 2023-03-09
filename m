Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A86B1A38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 04:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCID4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 22:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCID4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:56:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47979D7C1A;
        Wed,  8 Mar 2023 19:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gUhuwBkGNqQAsWUATCimoTKOwrk6cDQaNmIoLHcpFcc=; b=ygVMihU7V2DlUdXWp3kPVN3Bx/
        7ecOCmkT76cy8FeDhPRLvFdWrDf9Rssf3NpB6RdB9VQevcPHHMXAEQJNshzAAVDlm5YhTvvcWSneU
        c+aupjD+1U1C1oj2nr/HHVg93OAn6rpdi2ghAsDylld0WRru08Z643EAJkqNmPMnaCeAO9TMbnieo
        M02mbUUoyWTiGz1XQ/Db+2hfPcEeWogCLiiMnHH+ZMQJavzzs/M8Jp5rZrPZxTTJLUqe4wh86otB+
        ZLpp3r3A8eO2a/PEacBnxjqR1zwm4snO657Pd6O/qQdqOK/8cDdSDdCFqAHUbzDrVy7uon9S49FB+
        5cDtpjCA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pa7OI-007irx-KE; Thu, 09 Mar 2023 03:56:30 +0000
Date:   Wed, 8 Mar 2023 19:56:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V3 2/2] mm: =?iso-8859-1?Q?comp?=
 =?iso-8859-1?Q?action=3A_limit_illegal_input_parameters_of=A0compact=5Fme?=
 =?iso-8859-1?Q?mory?= interface
Message-ID: <ZAlY7jsj4daalgcY@bombadil.infradead.org>
References: <202303091142580726760@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303091142580726760@zte.com.cn>
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

On Thu, Mar 09, 2023 at 11:42:58AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Available only when CONFIG_COMPACTION is set. When 1 is written to
> the file, all zones are compacted such that free memory is available
> in contiguous blocks where possible.
> But echo others-parameter > compact_memory, this function will be
> triggered by writing parameters to the interface.
> 
> Applied this patch,
> sh/$ echo 1.1 > /proc/sys/vm/compact_memory
> sh/$ sh: write error: Invalid argument

Didn't echo 2 > /proc/sys/vm/compact_memory used to work too?

Why kill that? Did the docs say only 1 was possible? If not
perhaps the docs need to be updated?

  Luis
