Return-Path: <linux-fsdevel+bounces-57613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B64B23DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 03:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CF9685A4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC3A19F461;
	Wed, 13 Aug 2025 01:33:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB72C0F8F;
	Wed, 13 Aug 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048779; cv=none; b=IaneVLkSj4tduFoXJoGYyvmZYvDcExQvvi4Nxk7TaDsHdAGXPJgA02D2AGjvRKao5tHiYtmQaay/S7Uqd376M42NIUAnvFMjO0QFZnU3sGgaS3ytP5vhvrLBHAvGjBWhpPLEIf4zP54U2QVXvFFL0+QhG5cwBzGayWHZFTJtERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048779; c=relaxed/simple;
	bh=+ugcR71v8TM03e5waYZpAiHI/Hz68QFeU63iZMzu8YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGe3cI6Ud2gHLyINzQ7WT7oBJUw/QHYnIiH9uZ3jCpk523KdPNHsoFFTi56AYcOSxnGxCsZSxoysgOJsGiu91cUj29YTVkWhl+7ytbR9WsqAQkDevvnKK9VA8xY1lPHtymFhrsvx+QLCGSEErfPUTBUVywAbytMq8zARh0pHbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-d4-689beb3dbd50
Date: Wed, 13 Aug 2025 10:32:40 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Kleikamp <shaggy@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	kernel_team@skhynix.com
Subject: Re: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
Message-ID: <20250813013240.GA78125@system.software.com>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811143949.1117439-3-david@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHed67q8XrMnpshLAIS+liKJwu2uVLT9+KCsTIWvrWRpvGNNOo
	WEpWRmojL21qqXgrw5yWravXLLppiS7yghkuW2kZVs5LuUXUtx//8z8/zocj0IoSdoGgjYmX
	DDFqnYqTMbLPs4uWhTotmpV9dSrIq6rk4I59B0yZHvGQNl3LgLNpFEG3ycGDKSOXh7EqFw1t
	P09SMJBfwcN4TysPKcVVHFhyUigoffWNgsKnnTS0fz1FwWR/ELTeLODhYnYyglcD5Tzcu/+E
	gdd38jjorfzFwsSPaRYKbCYWvqcroXRshIdaYyMHv1wfWSi19TMw/sHOwLNsA9ytLuLgbfdP
	Gl5OtbLQUlfBQmcywLVKDVhaevkN/mTCZULE3PecIxZjO0PG3rygSNGQkSEXUoZ5YjP38ORc
	6mueFN8booj16lmOWEdNPHmcO8EQW/9qUmjMoklmUT0iD/Mr+a3KCNm6aEmnTZAMK8L2yjTD
	NQPUoabjiVODdZQRPd+ZhgQBi8F41LktDXl5sPyijXYzIy7Gnz62e5gT/bHdPu5hH3EJtqbe
	mGGZQIuOWfjc6RLGPZgrbsA2h5lyO+Ui4KxOnTtWiBKu+vGAd7Nc9MZPLr331GkxANunhzx1
	WlTismnBHXvNbN7vSGfdPE9chOtvtVJ/Tnsm4Jx3IX/YFzeU25lMJJr/s5r/s5r/Wa8g+ipS
	aGMS9GqtLni5JilGm7g8KlZvRTPPU3p8ctdtNNq2vRGJAlLNlretsWgUrDohLknfiLBAq3zk
	+btnInm0OumoZIjdYzisk+IakVJgVPPlq74fiVaIB9Tx0kFJOiQZ/k4pwWuBEQWFDXdGuHY7
	NpPH4AjapvTzDz+/MLSwfrDM3mDJnDj/LVxv8X6Rh4/ymwK7rlfX+gbrdc1NqJC0h/j6bdxi
	/bR6MnRpxbG1EZHsvmsLt0bqhpx7S7o6/EMyAvZ/8WsucJ4JDK0fGdy4vmxOTUt0blS4K3ax
	X3PsZbO5IPXDiZwwFROnUQcF0IY49W+ou5JiOAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRyG+Z/7VsOTGR2VSBddFMqMgl95SehDJ4OIKLuA5NBDW84Zm3kp
	pNnIUMt0eN3S0lCzBpaltsqSjWWjzLy0JmUhSksNpYuZ85YTIr89vO/7fHsZ3Duf9GMUqhRB
	rZIppZSYEB8I022OGDXKt+aVesH1BhMFj52HYVb/gobcuYcEjFp/IPiod9Ggv1ZGw0SDG4e3
	f7IwGKyop2Gqv50G3a0GCoylOgxqu39iUPXKgUPX90sYzAyEQntTJQ3WCjsJRSUXEXQP3qbh
	aaudgJ7H1yn4ZJonYXpyjoRKs56E3/n+UDsxTsNDrYWCefcICbXmAQKmvjoJeF2iBovDRcKT
	+9UUfPj4B4fO2XYSbC31JDguAtw1ycFo+0RHBfHTbj3iDZ87KN6o7SL4ib43GF89rCX4Qt0Y
	zZsN/TSfl91D87eeDmN8450cim/8oaf5l2XTBG8e2MlXaYtxvqC6DfHPK0z0wTUnxOEJglKR
	KqhDIuPE8rEHg9gZa2b67JcWTIs6juQiEcOx27nbRWbcwwS7nvs20rXIFLuRczqnFtmH3cQ1
	Zt9bYDGDs65lXN7lGsJTrGSjOLPLgOUihpGwwBU7lJ7YmxW4hslntIcl7ArOXj60OMfZYM45
	N7w4x1l/rm6O8cSiBbO1N5/08Cp2HdfW3I4VIIlhiW1YYhv+2zcRfgf5KFSpSTKFcscWTaI8
	Q6VI3xKfnNSIFl5SmzlT+Aj96tlrQSyDpMslb3cZ5d6kLFWTkWRBHINLfSQVsQuRJEGWcU5Q
	J59Un1UKGgvyZwjpakn0USHOmz0lSxESBeGMoP7XYozIT4uKb1S+mw5qjo/EbLa+FEnQ2qbX
	x/ev2+2MpXyrAsNWnfcj7HVXen33RBfaIkx5aCjmSExda+dp9zjrTk02DG7b9t6KbejvEEd0
	GiK3v2kOTCspovrUpnfH8hMOrfyVpvILCSgLd5hLL1wdKA+3UfvuhooCak7m1HtpsrhDuviN
	UkIjl4UG42qN7C9NYmcCIQMAAA==
X-CFilter-Loop: Reflected

On Mon, Aug 11, 2025 at 04:39:48PM +0200, David Hildenbrand wrote:
> At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
> and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
> return value that the code uses and expects.
> 
> Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
> for success.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/cmm.c |  2 +-
>  drivers/misc/vmw_balloon.c           |  4 +--
>  drivers/virtio/virtio_balloon.c      |  2 +-
>  fs/aio.c                             |  2 +-
>  fs/btrfs/inode.c                     |  4 +--
>  fs/hugetlbfs/inode.c                 |  4 +--
>  fs/jfs/jfs_metapage.c                |  8 +++---
>  include/linux/migrate.h              | 10 +------
>  mm/migrate.c                         | 40 +++++++++++++---------------
>  mm/migrate_device.c                  |  2 +-
>  mm/zsmalloc.c                        |  4 +--
>  11 files changed, 36 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 5e0a718d1be7b..0823fa2da1516 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -545,7 +545,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>         /* balloon page list reference */
>         put_page(page);
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;

Yeah.  The unnecessary thing has been kept.  Looks better to me.

Reviewed-by: Byungchul Park <byungchul@sk.com>

	Byungchul

>  static void cmm_balloon_compaction_init(void)
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 6653fc53c951c..6df51ee8db621 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1806,7 +1806,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>                  * the list after acquiring the lock.
>                  */
>                 get_page(newpage);
> -               ret = MIGRATEPAGE_SUCCESS;
> +               ret = 0;
>         }
> 
>         /* Update the balloon list under the @pages_lock */
> @@ -1817,7 +1817,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>          * If we succeed just insert it to the list and update the statistics
>          * under the lock.
>          */
> -       if (ret == MIGRATEPAGE_SUCCESS) {
> +       if (!ret) {
>                 balloon_page_insert(&b->b_dev_info, newpage);
>                 __count_vm_event(BALLOON_MIGRATE);
>         }
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index e299e18346a30..eae65136cdfb5 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -875,7 +875,7 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>         balloon_page_finalize(page);
>         put_page(page); /* balloon reference */
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
>  #endif /* CONFIG_BALLOON_COMPACTION */
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 7fc7b6221312c..059e03cfa088c 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -445,7 +445,7 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
>         folio_get(dst);
> 
>         rc = folio_migrate_mapping(mapping, dst, src, 1);
> -       if (rc != MIGRATEPAGE_SUCCESS) {
> +       if (rc) {
>                 folio_put(dst);
>                 goto out_unlock;
>         }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b77dd22b8cdbe..1d64fee6f59e6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7411,7 +7411,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
>  {
>         int ret = filemap_migrate_folio(mapping, dst, src, mode);
> 
> -       if (ret != MIGRATEPAGE_SUCCESS)
> +       if (ret)
>                 return ret;
> 
>         if (folio_test_ordered(src)) {
> @@ -7419,7 +7419,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
>                 folio_set_ordered(dst);
>         }
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
>  #else
>  #define btrfs_migrate_folio NULL
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 09d4baef29cf9..34d496a2b7de6 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1052,7 +1052,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
>         int rc;
> 
>         rc = migrate_huge_page_move_mapping(mapping, dst, src);
> -       if (rc != MIGRATEPAGE_SUCCESS)
> +       if (rc)
>                 return rc;
> 
>         if (hugetlb_folio_subpool(src)) {
> @@ -1063,7 +1063,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
> 
>         folio_migrate_flags(dst, src);
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
>  #else
>  #define hugetlbfs_migrate_folio NULL
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index b98cf3bb6c1fe..871cf4fb36366 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -169,7 +169,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
>         }
> 
>         rc = filemap_migrate_folio(mapping, dst, src, mode);
> -       if (rc != MIGRATEPAGE_SUCCESS)
> +       if (rc)
>                 return rc;
> 
>         for (i = 0; i < MPS_PER_PAGE; i++) {
> @@ -199,7 +199,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
>                 }
>         }
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
>  #endif /* CONFIG_MIGRATION */
> 
> @@ -242,7 +242,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
>                 return -EAGAIN;
> 
>         rc = filemap_migrate_folio(mapping, dst, src, mode);
> -       if (rc != MIGRATEPAGE_SUCCESS)
> +       if (rc)
>                 return rc;
> 
>         if (unlikely(insert_metapage(dst, mp)))
> @@ -253,7 +253,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
>         mp->folio = dst;
>         remove_metapage(src, mp);
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
>  #endif /* CONFIG_MIGRATION */
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 40f2b5a37efbb..02f11704fb686 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -12,13 +12,6 @@ typedef void free_folio_t(struct folio *folio, unsigned long private);
> 
>  struct migration_target_control;
> 
> -/*
> - * Return values from addresss_space_operations.migratepage():
> - * - negative errno on page migration failure;
> - * - zero on page migration success;
> - */
> -#define MIGRATEPAGE_SUCCESS            0
> -
>  /**
>   * struct movable_operations - Driver page migration
>   * @isolate_page:
> @@ -34,8 +27,7 @@ struct migration_target_control;
>   * @src page.  The driver should copy the contents of the
>   * @src page to the @dst page and set up the fields of @dst page.
>   * Both pages are locked.
> - * If page migration is successful, the driver should
> - * return MIGRATEPAGE_SUCCESS.
> + * If page migration is successful, the driver should return 0.
>   * If the driver cannot migrate the page at the moment, it can return
>   * -EAGAIN.  The VM interprets this as a temporary migration failure and
>   * will retry it later.  Any other error value is a permanent migration
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e9dacf1028dc7..2db4974178e6a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -209,18 +209,17 @@ static void putback_movable_ops_page(struct page *page)
>   * src and dst are also released by migration core. These pages will not be
>   * folios in the future, so that must be reworked.
>   *
> - * Returns MIGRATEPAGE_SUCCESS on success, otherwise a negative error
> - * code.
> + * Returns 0 on success, otherwise a negative error code.
>   */
>  static int migrate_movable_ops_page(struct page *dst, struct page *src,
>                 enum migrate_mode mode)
>  {
> -       int rc = MIGRATEPAGE_SUCCESS;
> +       int rc;
> 
>         VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(src), src);
>         VM_WARN_ON_ONCE_PAGE(!PageMovableOpsIsolated(src), src);
>         rc = page_movable_ops(src)->migrate_page(dst, src, mode);
> -       if (rc == MIGRATEPAGE_SUCCESS)
> +       if (!rc)
>                 ClearPageMovableOpsIsolated(src);
>         return rc;
>  }
> @@ -565,7 +564,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>                 if (folio_test_swapbacked(folio))
>                         __folio_set_swapbacked(newfolio);
> 
> -               return MIGRATEPAGE_SUCCESS;
> +               return 0;
>         }
> 
>         oldzone = folio_zone(folio);
> @@ -666,7 +665,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>         }
>         local_irq_enable();
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
> 
>  int folio_migrate_mapping(struct address_space *mapping,
> @@ -715,7 +714,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
> 
>         xas_unlock_irq(&xas);
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
> 
>  /*
> @@ -831,14 +830,14 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>                 return rc;
> 
>         rc = __folio_migrate_mapping(mapping, dst, src, expected_count);
> -       if (rc != MIGRATEPAGE_SUCCESS)
> +       if (rc)
>                 return rc;
> 
>         if (src_private)
>                 folio_attach_private(dst, folio_detach_private(src));
> 
>         folio_migrate_flags(dst, src);
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
> 
>  /**
> @@ -945,7 +944,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>         }
> 
>         rc = filemap_migrate_folio(mapping, dst, src, mode);
> -       if (rc != MIGRATEPAGE_SUCCESS)
> +       if (rc)
>                 goto unlock_buffers;
> 
>         bh = head;
> @@ -1049,7 +1048,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
>   *
>   * Return value:
>   *   < 0 - error code
> - *  MIGRATEPAGE_SUCCESS - success
> + *     0 - success
>   */
>  static int move_to_new_folio(struct folio *dst, struct folio *src,
>                                 enum migrate_mode mode)
> @@ -1077,7 +1076,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>         else
>                 rc = fallback_migrate_folio(mapping, dst, src, mode);
> 
> -       if (rc == MIGRATEPAGE_SUCCESS) {
> +       if (!rc) {
>                 /*
>                  * For pagecache folios, src->mapping must be cleared before src
>                  * is freed. Anonymous folios must stay anonymous until freed.
> @@ -1427,7 +1426,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>         if (folio_ref_count(src) == 1) {
>                 /* page was freed from under us. So we are done. */
>                 folio_putback_hugetlb(src);
> -               return MIGRATEPAGE_SUCCESS;
> +               return 0;
>         }
> 
>         dst = get_new_folio(src, private);
> @@ -1490,8 +1489,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>                 rc = move_to_new_folio(dst, src, mode);
> 
>         if (page_was_mapped)
> -               remove_migration_ptes(src,
> -                       rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
> +               remove_migration_ptes(src, !rc ? dst : src, 0);
> 
>  unlock_put_anon:
>         folio_unlock(dst);
> @@ -1500,7 +1498,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>         if (anon_vma)
>                 put_anon_vma(anon_vma);
> 
> -       if (rc == MIGRATEPAGE_SUCCESS) {
> +       if (!rc) {
>                 move_hugetlb_state(src, dst, reason);
>                 put_new_folio = NULL;
>         }
> @@ -1508,7 +1506,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>  out_unlock:
>         folio_unlock(src);
>  out:
> -       if (rc == MIGRATEPAGE_SUCCESS)
> +       if (!rc)
>                 folio_putback_hugetlb(src);
>         else if (rc != -EAGAIN)
>                 list_move_tail(&src->lru, ret);
> @@ -1618,7 +1616,7 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
>                                                       reason, ret_folios);
>                         /*
>                          * The rules are:
> -                        *      Success: hugetlb folio will be put back
> +                        *      0: hugetlb folio will be put back
>                          *      -EAGAIN: stay on the from list
>                          *      -ENOMEM: stay on the from list
>                          *      Other errno: put on ret_folios list
> @@ -1635,7 +1633,7 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
>                                 retry++;
>                                 nr_retry_pages += nr_pages;
>                                 break;
> -                       case MIGRATEPAGE_SUCCESS:
> +                       case 0:
>                                 stats->nr_succeeded += nr_pages;
>                                 break;
>                         default:
> @@ -1689,7 +1687,7 @@ static void migrate_folios_move(struct list_head *src_folios,
>                                 reason, ret_folios);
>                 /*
>                  * The rules are:
> -                *      Success: folio will be freed
> +                *      0: folio will be freed
>                  *      -EAGAIN: stay on the unmap_folios list
>                  *      Other errno: put on ret_folios list
>                  */
> @@ -1699,7 +1697,7 @@ static void migrate_folios_move(struct list_head *src_folios,
>                         *thp_retry += is_thp;
>                         *nr_retry_pages += nr_pages;
>                         break;
> -               case MIGRATEPAGE_SUCCESS:
> +               case 0:
>                         stats->nr_succeeded += nr_pages;
>                         stats->nr_thp_succeeded += is_thp;
>                         break;
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index e05e14d6eacdb..abd9f6850db65 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -778,7 +778,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>                 if (migrate && migrate->fault_page == page)
>                         extra_cnt = 1;
>                 r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
> -               if (r != MIGRATEPAGE_SUCCESS)
> +               if (r)
>                         src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>                 else
>                         folio_migrate_flags(newfolio, folio);
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 2c5e56a653544..84eb91d47a226 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1746,7 +1746,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>          * instead.
>          */
>         if (!zpdesc->zspage)
> -               return MIGRATEPAGE_SUCCESS;
> +               return 0;
> 
>         /* The page is locked, so this pointer must remain valid */
>         zspage = get_zspage(zpdesc);
> @@ -1813,7 +1813,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>         reset_zpdesc(zpdesc);
>         zpdesc_put(zpdesc);
> 
> -       return MIGRATEPAGE_SUCCESS;
> +       return 0;
>  }
> 
>  static void zs_page_putback(struct page *page)
> --
> 2.50.1
> 

