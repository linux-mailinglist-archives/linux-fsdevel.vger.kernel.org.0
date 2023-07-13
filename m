Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C567751787
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjGMEeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjGMEeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573221BC6;
        Wed, 12 Jul 2023 21:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E904F619B0;
        Thu, 13 Jul 2023 04:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC50C433C7;
        Thu, 13 Jul 2023 04:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689222837;
        bh=m0FB5ZeHmfo0G6Ai49vHuM1+N5o2MRDnfUUjgg43eVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5Cbf2ks3NWcCKaME7JtBfjJiO11tQA0ZoVmCYsVkhEI4JFyVj2sSmyP4FnP8OzxI
         U23Eb90s8eMA6OL9CNPJSmGzX7PL8kbV1R9cDIGEtGGcjMX3o7YAH4ok/geq3yaA3R
         m1VmoNN48/U4D+HhkZEVGIvgkWNad8sBrG0NoKB7lJZnrAnxW1IauWj7foEJYaSuq9
         bjt252bEOFFIpFYw76xty+4tUEgEVyeXPo8PulL3nzRY3q1UTNxRQaUgNQX8ygGBLM
         lD4DvIAG0wabLzIHSdwpKHnmIBTQVpx2RlTO3lbwLJe2S5dxfVkfUudsFStRWT1mkF
         5wa5fWJJ9L7sg==
Date:   Wed, 12 Jul 2023 21:33:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCHv11 5/8] iomap: Use iomap_punch_t typedef
Message-ID: <20230713043356.GE108251@frogsfrogsfrogs>
References: <cover.1688188958.git.ritesh.list@gmail.com>
 <b41412dae42389fc1db9d6cb37810cae5d943c0f.1688188958.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41412dae42389fc1db9d6cb37810cae5d943c0f.1688188958.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 01, 2023 at 01:04:38PM +0530, Ritesh Harjani (IBM) wrote:
> It makes it much easier if we have iomap_punch_t typedef for "punch"
> function pointer in all delalloc related punch, scan and release
> functions. It will be useful in later patches when we will factor out
> iomap_write_delalloc_punch() function.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thank goodness
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index cddf01b96d8a..33fc5ed0049f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -23,6 +23,7 @@
>  
>  #define IOEND_BATCH_SIZE	4096
>  
> +typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
>  /*
>   * Structure allocated for each folio to track per-block uptodate state
>   * and I/O completions.
> @@ -900,7 +901,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>   */
>  static int iomap_write_delalloc_scan(struct inode *inode,
>  		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
> -		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
> +		iomap_punch_t punch)
>  {
>  	while (start_byte < end_byte) {
>  		struct folio	*folio;
> @@ -978,8 +979,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>   * the code to subtle off-by-one bugs....
>   */
>  static int iomap_write_delalloc_release(struct inode *inode,
> -		loff_t start_byte, loff_t end_byte,
> -		int (*punch)(struct inode *inode, loff_t pos, loff_t length))
> +		loff_t start_byte, loff_t end_byte, iomap_punch_t punch)
>  {
>  	loff_t punch_start_byte = start_byte;
>  	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
> @@ -1072,8 +1072,7 @@ static int iomap_write_delalloc_release(struct inode *inode,
>   */
>  int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  		struct iomap *iomap, loff_t pos, loff_t length,
> -		ssize_t written,
> -		int (*punch)(struct inode *inode, loff_t pos, loff_t length))
> +		ssize_t written, iomap_punch_t punch)
>  {
>  	loff_t			start_byte;
>  	loff_t			end_byte;
> -- 
> 2.40.1
> 
