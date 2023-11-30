Return-Path: <linux-fsdevel+bounces-4345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3744C7FECFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6859B1C2074A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4C3C06E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vG4lzZDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A5BBD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 01:27:21 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SgrSS36L1zMqYF5;
	Thu, 30 Nov 2023 09:27:20 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SgrSR4WgkzMpp9r;
	Thu, 30 Nov 2023 10:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701336440;
	bh=4Hwh9jqNtIQyPgPIRzGabg31L3sA9cGlMuOkzDXtKIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vG4lzZDTvVqEotIkDzZpitx3EuZz4xNK8oGO9R5NYhjn7pzrlkZQMviwyNTs9qWKI
	 a36WYL5+NjzqZN5axAh5tuzNjugIszABdYM5AlcVWHZHl8U3a6I3Gr3anLY6PIs9Js
	 YWpP3ARI9uir6KL8cbimpr733Wn9jerDB9c8+F44=
Date: Thu, 30 Nov 2023 10:27:18 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/9] landlock: Remove remaining "inline" modifiers in
 .c files
Message-ID: <20231130.beetuo4Chuso@digikod.net>
References: <20231124173026.3257122-1-gnoack@google.com>
 <20231124173026.3257122-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124173026.3257122-2-gnoack@google.com>
X-Infomaniak-Routing: alpha


Thanks for this cleanup. Maybe add a (one-line) explanation?

On Fri, Nov 24, 2023 at 06:30:18PM +0100, Günther Noack wrote:
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  security/landlock/fs.c      | 26 +++++++++++++-------------
>  security/landlock/ruleset.c |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index bc7c126deea2..9ba989ef46a5 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -193,7 +193,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>   *
>   * Returns NULL if no rule is found or if @dentry is negative.
>   */
> -static inline const struct landlock_rule *
> +static const struct landlock_rule *
>  find_rule(const struct landlock_ruleset *const domain,
>  	  const struct dentry *const dentry)
>  {
> @@ -220,7 +220,7 @@ find_rule(const struct landlock_ruleset *const domain,
>   * sockfs, pipefs), but can still be reachable through
>   * /proc/<pid>/fd/<file-descriptor>
>   */
> -static inline bool is_nouser_or_private(const struct dentry *dentry)
> +static bool is_nouser_or_private(const struct dentry *dentry)
>  {
>  	return (dentry->d_sb->s_flags & SB_NOUSER) ||
>  	       (d_is_positive(dentry) &&
> @@ -264,7 +264,7 @@ static const struct landlock_ruleset *get_current_fs_domain(void)
>   *
>   * @layer_masks_child2: Optional child masks.
>   */
> -static inline bool no_more_access(
> +static bool no_more_access(
>  	const layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
>  	const layer_mask_t (*const layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS],
>  	const bool child1_is_directory,
> @@ -316,7 +316,7 @@ static inline bool no_more_access(
>   *
>   * Returns true if the request is allowed, false otherwise.
>   */
> -static inline bool
> +static bool
>  scope_to_request(const access_mask_t access_request,
>  		 layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
>  {
> @@ -335,7 +335,7 @@ scope_to_request(const access_mask_t access_request,
>   * Returns true if there is at least one access right different than
>   * LANDLOCK_ACCESS_FS_REFER.
>   */
> -static inline bool
> +static bool
>  is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
>  	  const access_mask_t access_request)
>  {
> @@ -551,9 +551,9 @@ static bool is_access_to_paths_allowed(
>  	return allowed_parent1 && allowed_parent2;
>  }
>  
> -static inline int check_access_path(const struct landlock_ruleset *const domain,
> -				    const struct path *const path,
> -				    access_mask_t access_request)
> +static int check_access_path(const struct landlock_ruleset *const domain,
> +			     const struct path *const path,
> +			     access_mask_t access_request)
>  {
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>  
> @@ -565,8 +565,8 @@ static inline int check_access_path(const struct landlock_ruleset *const domain,
>  	return -EACCES;
>  }
>  
> -static inline int current_check_access_path(const struct path *const path,
> -					    const access_mask_t access_request)
> +static int current_check_access_path(const struct path *const path,
> +				     const access_mask_t access_request)
>  {
>  	const struct landlock_ruleset *const dom = get_current_fs_domain();
>  
> @@ -575,7 +575,7 @@ static inline int current_check_access_path(const struct path *const path,
>  	return check_access_path(dom, path, access_request);
>  }
>  
> -static inline access_mask_t get_mode_access(const umode_t mode)
> +static access_mask_t get_mode_access(const umode_t mode)
>  {
>  	switch (mode & S_IFMT) {
>  	case S_IFLNK:
> @@ -600,7 +600,7 @@ static inline access_mask_t get_mode_access(const umode_t mode)
>  	}
>  }
>  
> -static inline access_mask_t maybe_remove(const struct dentry *const dentry)
> +static access_mask_t maybe_remove(const struct dentry *const dentry)
>  {
>  	if (d_is_negative(dentry))
>  		return 0;
> @@ -1086,7 +1086,7 @@ static int hook_path_truncate(const struct path *const path)
>   * Returns the access rights that are required for opening the given file,
>   * depending on the file type and open mode.
>   */
> -static inline access_mask_t
> +static access_mask_t
>  get_required_file_open_access(const struct file *const file)
>  {
>  	access_mask_t access = 0;
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index ffedc99f2b68..789c81b26a50 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -305,7 +305,7 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
>  	return insert_rule(ruleset, id, &layers, ARRAY_SIZE(layers));
>  }
>  
> -static inline void get_hierarchy(struct landlock_hierarchy *const hierarchy)
> +static void get_hierarchy(struct landlock_hierarchy *const hierarchy)
>  {
>  	if (hierarchy)
>  		refcount_inc(&hierarchy->usage);
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 
> 

