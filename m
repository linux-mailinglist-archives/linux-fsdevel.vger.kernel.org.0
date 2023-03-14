Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69FD6BA2A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCNWlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCNWlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:41:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED0F2F78F
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:41:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMf2vc012497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833663; bh=zREPB+ckC2lD+rhNG19m4/aT58fPFdA1X7WJ4DW97p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ls9vcs7RF2ZhZWX9zycDR5dUgyotOaKs8ou4Gla7PzkAor5Ne4Zf5sJa3hwAoCsJw
         89yy75KrmUnEcZmZtch+t9PiJZ60JK+FTWAOWG5nJcewsGi9lVJrcL8NfZiMipzeiz
         JTDFRlFL1Xrkr3uXAwIeDPdad82ZfojOsGoQIr5LWFhfhsL8AKGxSLMIF5Es4dk0Ft
         Oy5WyfE4tpIpEW9B0kZym7/BYtzh3ubLlDXT4Tl0UIgfc5SnrjUtASJzsNtEDMCvmm
         8jSfUx5QcFoF5t9Rxv+/C2hw050ncsPIF0WM2Kp0vrmJ+vs87/Wi5lDACSh8lYmDUn
         c6aPWjg9bp9oQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F265915C5830; Tue, 14 Mar 2023 18:41:01 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:41:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/31] ext4: Convert ext4_write_end() to use a folio
Message-ID: <20230314224101.GD860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-18-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:24:01PM +0000, Matthew Wilcox (Oracle) wrote:
> Convert the incoming struct page to a folio.  Replaces two implicit
> calls to compound_head() with one explicit call.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
