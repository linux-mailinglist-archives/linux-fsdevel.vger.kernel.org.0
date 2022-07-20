Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E957AF6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 05:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiGTDTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 23:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiGTDS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:18:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94A23BD9;
        Tue, 19 Jul 2022 20:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gu/Ya+HLNKChQ8FEyH8dSabXYrpS2k0ipyhSkSCwcB4=; b=t8PVoSzgQnNZWE9p3TMdL0mIlW
        XiG6sISPQ0jVBatZcZqIcR4peDcbenoH6BpNAOffxB2Dc+JvrVwPysQk+gKHVLA0BggDUADM1f8bE
        2tZ6k990YN76GaK+hgW0b9n4gjUpAxSRZiPIgxnmrIxBSZ/bIcToTJtLtcaF+540hZrpWrxDSdXWF
        k/Ct07PiX/Q23asl0hVTM26S1oazjBEszYRzaT8ekid42AwLzJHV1ywievqvUcXHIinG6BrsTsZfU
        vMbVxcK4otZF8VGTI5u5OvxLNZarAWLtaYHBmWYwu2ruZMy2W//pytbGa0i66MxipFQOi7hcM78jv
        g6uKczQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE0Ed-00E78p-FA; Wed, 20 Jul 2022 03:18:51 +0000
Date:   Wed, 20 Jul 2022 04:18:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <Ytd0G0glVWdv+iaD@casper.infradead.org>
References: <20220719234131.235187-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719234131.235187-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:41:31PM -0700, Jeremy Bongio wrote:
> +/*
> + * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
> + */
> +struct fsuuid {
> +	__u32       fsu_len;
> +	__u32       fsu_flags;
> +	__u8        fsu_uuid[];
> +};

A UUID has a defined size (128 bits):
https://en.wikipedia.org/wiki/Universally_unique_identifier

Why are we defining flags and len?
