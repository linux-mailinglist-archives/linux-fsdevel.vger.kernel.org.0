Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE17128DC2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgJNI7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgJNI7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:59:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA991C045857
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 22:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=SNNYlaXixvQzsLiUGbPT33SFk/27EOKApLvok+myvys=; b=RRHdIFn9L2kCrlyRR3iZOCG+W2
        895uFCxeBCabDmHqiQ0dcuNhjX0yt4CVmN9Llqeb7VqHpQ21cyoNI0agc2KemhGpFN1ayM/NgABJI
        1xMFcAkdQtCjNOqtw8XPK0Fep6X6AEPDst707cJM2jLNj42QtzLFepN8hAbiJifSCOCeGOxQhWJQN
        aC3FNnuyTxLbGOatjgIcUEUTwpEt3sxS/p4uLxEhQtY8fPBNQzEeCkA5/LKPydpr7UQJEfPMW8r2Y
        1/Ob7YLrtyFKtlSFSPrfv0i2QkRB8qskNcRPN8S/c7ByBJF2go9XlxgBprjtP341QkfDF5bJBGCaM
        vBIwbYEg==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSZCv-0007e5-PK; Wed, 14 Oct 2020 05:20:14 +0000
Subject: Re: [PATCH] ubifs: delete duplicated words + other fixes
To:     linux-fsdevel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
References: <20200805024935.12331-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <62f3156d-a720-437e-d859-3b1c203a0653@infradead.org>
Date:   Tue, 13 Oct 2020 22:20:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200805024935.12331-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping.

On 8/4/20 7:49 PM, Randy Dunlap wrote:
> Delete repeated words in fs/ubifs/.
> {negative, is, of, and, one, it}
> where "it it" was changed to "if it".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> To: linux-fsdevel@vger.kernel.org
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> ---
>  fs/ubifs/debug.c    |    2 +-
>  fs/ubifs/dir.c      |    2 +-
>  fs/ubifs/file.c     |    2 +-
>  fs/ubifs/io.c       |    2 +-
>  fs/ubifs/replay.c   |    2 +-
>  fs/ubifs/tnc.c      |    2 +-
>  fs/ubifs/tnc_misc.c |    3 +--
>  7 files changed, 7 insertions(+), 8 deletions(-)
> 
> --- linux-next-20200804.orig/fs/ubifs/debug.c
> +++ linux-next-20200804/fs/ubifs/debug.c
> @@ -1012,7 +1012,7 @@ void dbg_save_space_info(struct ubifs_in
>   *
>   * This function compares current flash space information with the information
>   * which was saved when the 'dbg_save_space_info()' function was called.
> - * Returns zero if the information has not changed, and %-EINVAL it it has
> + * Returns zero if the information has not changed, and %-EINVAL if it has
>   * changed.
>   */
>  int dbg_check_space_info(struct ubifs_info *c)
> --- linux-next-20200804.orig/fs/ubifs/dir.c
> +++ linux-next-20200804/fs/ubifs/dir.c
> @@ -840,7 +840,7 @@ out_fname:
>   *
>   * This function checks if directory @dir is empty. Returns zero if the
>   * directory is empty, %-ENOTEMPTY if it is not, and other negative error codes
> - * in case of of errors.
> + * in case of errors.
>   */
>  int ubifs_check_dir_empty(struct inode *dir)
>  {
> --- linux-next-20200804.orig/fs/ubifs/file.c
> +++ linux-next-20200804/fs/ubifs/file.c
> @@ -205,7 +205,7 @@ static void release_new_page_budget(stru
>   * @c: UBIFS file-system description object
>   *
>   * This is a helper function which releases budget corresponding to the budget
> - * of changing one one page of data which already exists on the flash media.
> + * of changing one page of data which already exists on the flash media.
>   */
>  static void release_existing_page_budget(struct ubifs_info *c)
>  {
> --- linux-next-20200804.orig/fs/ubifs/io.c
> +++ linux-next-20200804/fs/ubifs/io.c
> @@ -1046,7 +1046,7 @@ out:
>   * @lnum: logical eraseblock number
>   * @offs: offset within the logical eraseblock
>   *
> - * This function reads a node of known type and and length, checks it and
> + * This function reads a node of known type and length, checks it and
>   * stores in @buf. Returns zero in case of success, %-EUCLEAN if CRC mismatched
>   * and a negative error code in case of failure.
>   */
> --- linux-next-20200804.orig/fs/ubifs/replay.c
> +++ linux-next-20200804/fs/ubifs/replay.c
> @@ -574,7 +574,7 @@ static int authenticate_sleb_hash(struct
>   * @c: UBIFS file-system description object
>   * @sleb: the scan LEB to authenticate
>   * @log_hash:
> - * @is_last: if true, this is is the last LEB
> + * @is_last: if true, this is the last LEB
>   *
>   * This function iterates over the buds of a single LEB authenticating all buds
>   * with the authentication nodes on this LEB. Authentication nodes are written
> --- linux-next-20200804.orig/fs/ubifs/tnc.c
> +++ linux-next-20200804/fs/ubifs/tnc.c
> @@ -378,7 +378,7 @@ static void lnc_free(struct ubifs_zbranc
>   *
>   * This function reads a "hashed" node defined by @zbr from the leaf node cache
>   * (in it is there) or from the hash media, in which case the node is also
> - * added to LNC. Returns zero in case of success or a negative negative error
> + * added to LNC. Returns zero in case of success or a negative error
>   * code in case of failure.
>   */
>  static int tnc_read_hashed_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
> --- linux-next-20200804.orig/fs/ubifs/tnc_misc.c
> +++ linux-next-20200804/fs/ubifs/tnc_misc.c
> @@ -455,8 +455,7 @@ out:
>   * @node: node is returned here
>   *
>   * This function reads a node defined by @zbr from the flash media. Returns
> - * zero in case of success or a negative negative error code in case of
> - * failure.
> + * zero in case of success or a negative error code in case of failure.
>   */
>  int ubifs_tnc_read_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
>  			void *node)
> 


-- 
~Randy
