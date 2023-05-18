Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB70708554
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 17:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjERPtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjERPtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 11:49:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4555518C;
        Thu, 18 May 2023 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Wj44BzKpaHyBp+gdrgIA4sMoESvez2SvKKqEb+cwLYY=; b=ZynP9GCh61MTBTsXEvcDvsDD2o
        oZ9c+vVUIuz8GUvOGE0Bd6ivIoU/AVXfg0r3GP+CTUK70/1RiGKJoZzk10q5uUAF1dgqauFmwkgQr
        Tlc6kBN5P3RvYbm9HkQydZqqRoWb1P2TOc4MjG4SaihyP6wGGtIdKeOzKt7kZsm/T9/fneNwAGoQu
        tI9Pd9K0FyHM0h7IEox3l94kpzh1EWO0nl0IktePQ96Z2bwY059Z/ti9XlhALCKpEYX9R39vgif4P
        zlOq8UekD4JE5A3VTe4IkvhOaNRs244CbR7H2QyuEc0px3sV+txTGsdhA7R+Z22eOviL9dHXHjcIb
        xPK+iLWQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzfsd-00DMGt-0w;
        Thu, 18 May 2023 15:49:27 +0000
Message-ID: <707b28de-2449-5cf3-9360-b2faec0481c7@infradead.org>
Date:   Thu, 18 May 2023 08:49:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] Documentation: add initial iomap kdoc
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net, jake@lwn.net,
        hch@infradead.org, djwong@kernel.org, dchinner@redhat.com
Cc:     ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
References: <20230518150105.3160445-1-mcgrof@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230518150105.3160445-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/18/23 08:01, Luis Chamberlain wrote:
> To help with iomap adoption / porting I set out the goal to try to
> help improve the iomap documentation and get general guidance for
> filesystem conversions over from buffer-head in time for this year's
> LSFMM. The end results thanks to the review of Darrick, Christoph and
> others is on the kernelnewbies wiki [0].
> 
> This brings this forward a relevant subset of that documentation to
> the kernel in kdoc format and also kdoc'ifies the existing documentation
> on iomap.h.
> 
> Tested with:
> 
> make htmldocs SPHINXDIRS="filesystems"
> 
> Then looking at the docs produced on:
> 
> Documentation/output/filesystems/iomap.html
> 
> [0] https://kernelnewbies.org/KernelProjects/iomap
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Changes on v2:
> 
>   * use 80 char length as if we're in the 1980's

Well, like Jon said, long lines are difficult to read, even on printed paper.
That's (at least one reason) why newspapers(!) have narrow columns of print.

Anyway, thanks for doing it.

> 
>  Documentation/filesystems/index.rst |   1 +
>  Documentation/filesystems/iomap.rst | 253 +++++++++++++++++++++
>  include/linux/iomap.h               | 336 ++++++++++++++++++----------
>  3 files changed, 468 insertions(+), 122 deletions(-)
>  create mode 100644 Documentation/filesystems/iomap.rst
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index fbb2b5ada95b..6186ab7c3ea8 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -34,6 +34,7 @@ algorithms work.
>     seq_file
>     sharedsubtree
>     idmappings
> +   iomap
>  
>     automount-support
>  
> diff --git a/Documentation/filesystems/iomap.rst b/Documentation/filesystems/iomap.rst
> new file mode 100644
> index 000000000000..be487030fcff
> --- /dev/null
> +++ b/Documentation/filesystems/iomap.rst
> @@ -0,0 +1,253 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _iomap:
> +
> +..
> +        Mapping of heading styles within this document:
> +        Heading 1 uses "====" above and below
> +        Heading 2 uses "===="
> +        Heading 3 uses "----"
> +        Heading 4 uses "````"
> +        Heading 5 uses "^^^^"
> +        Heading 6 uses "~~~~"
> +        Heading 7 uses "...."
> +
> +        Sections are manually numbered because apparently that's what everyone
> +        does in the kernel.
> +.. contents:: Table of Contents
> +   :local:
> +
> +=====
> +iomap
> +=====
> +
> +.. kernel-doc:: include/linux/iomap.h
> +
> +A modern block abstraction
> +==========================
> +
> +**iomap** allows filesystems to query storage media for data using *byte
> +ranges*. Since block mapping are provided for a *byte ranges* for cache data in

                        mappings

> +memory, in the page cache, naturally this implies operations on block ranges
> +will also deal with *multipage* operations in the page cache. **Folios** are
> +used to help provide *multipage* operations in memory for the *byte ranges*
> +being worked on.
> +
> +
> +iomap IO interfaces
> +===================
> +
> +You call **iomap** depending on the type of filesystem operation you are working
> +on. We detail some of these interactions below.
> +
> +iomap for bufferred IO writes

             buffered

> +-----------------------------
> +
> +You call **iomap** for buffered IO with:
> +
> + * ``iomap_file_buffered_write()`` - for buffered writes
> + * ``iomap_page_mkwrite()`` - when dealing callbacks for

                                      dealing with callbacks for

> +    ``struct vm_operations_struct``
> +
> +  * ``struct vm_operations_struct.page_mkwrite()``
> +  * ``struct vm_operations_struct.fault()``
> +  * ``struct vm_operations_struct.huge_fault()``
> +  * ``struct vm_operations_struct`.pfn_mkwrite()``

What are these 4 structs for?  Or why the blank line above them?
Confusing.

> +
> +You *may* use buffered writes to also deal with ``fallocate()``:
> +
> + * ``iomap_zero_range()`` on fallocate for zeroing
> + * ``iomap_truncate_page()`` on fallocate for truncation
> +
> +Typically you'd also happen to use these on paths when updating an inode's size.
> +
> +iomap for direct IO
> +-------------------
> +
> +You call **iomap** for direct IO with:
> +
> + * ``iomap_dio_rw()``
> +
> +You **may** use direct IO writes to also deal with ``fallocate()``:
> +
> + * ``iomap_zero_range()`` on fallocate for zeroing
> + * ``iomap_truncate_page()`` on fallocate for truncation
> +
> +Typically you'd also happen to use these on paths when updating an inode's size.

                   also use these on paths ...

> +
> +iomap for reads
> +---------------
> +
> +You can call into **iomap** for reading, ie, dealing with the filesystems's

                                            i.e.,

> +``struct file_operations``:
> +
> + * ``struct file_operations.read_iter()``: note that depending on the type of
> +   read your filesystem might use ``iomap_dio_rw()`` for direct IO,
> +   generic_file_read_iter() for buffered IO and
> +   ``dax_iomap_rw()`` for DAX.
> + * ``struct file_operations.remap_file_range()`` - currently the special
> +   ``dax_remap_file_range_prep()`` helper is provided for DAX mode reads.
> +
> +iomap for userspace file extent mapping
> +---------------------------------------
> +
> +The ``fiemap`` ioctl can be used to allow userspace to get a file extent
> +mapping. The older ``bmap()`` (aka ``FIBMAP``)  allows the VM to map logical
> +block offset to physical block number.  ``bmap()`` is a legacy block mapping
> +operation supported only for the ioctl and two areas in the kernel which likely
> +are broken (the default swapfile implementation and odd md bitmap code).
> +``bmap()`` was only useful in the days of ext2 when there were no support for
> +delalloc or unwritten extents. Consequently, the interface reports nothing for
> +those types of mappings. Because of this we don't want filesystems to start
> +exporting this interface if they don't already do so.
> +
> +The ``fiemap`` ioctl is supported through an inode ``struct
> +inode_operations.fiemap()`` callback.
> +
> +You would use ``iomap_fiemap()`` to provide the mapping. You could use two
> +seperate ``struct iomap_ops`` one for when requested to also map extended

   separate

> +attributes (``FIEMAP_FLAG_XATTR``) and your another ``struct iomap_ops`` for

                                          yet

> +regular read ``struct iomap_ops`` when there is no need for extended attributes.
> +In the future **iomap** may provide its own dedicated ops structure for
> +``fiemap``.
> +
> +``iomap_bmap()`` exists and should *only be used* by filesystems that
> +**already** supported ``FIBMAP``.  ``FIBMAP`` **should not be used** with the

               support

> +address_space -- we have iomap readpages and writepages for that.
> +
> +iomap for assisting the VFS
> +---------------------------
> +
> +A filesystem also needs to call **iomap** when assisting the VFS manipulating a
> +file into the page cache.
> +
> +iomap for VFS reading
> +---------------------
> +
> +A filesystem can call **iomap** to deal with the VFS reading a file into folios
> +with:
> +
> + * ``iomap_bmap()`` - called to assist the VFS when manipulating page cache with
> +   ``struct address_space_operations.bmap()``, to help the VFS map a logical
> +   block offset to physical block number.
> + * ``iomap_read_folio()`` - called to assist the page cache with
> +   ``struct address_space_operations.read_folio()``
> + * ``iomap_readahead()`` - called to assist the page cache with
> +   ``struct address_space_operations.readahead()``
> +
> +iomap for VFS writepages
> +------------------------
> +
> +A filesystem can call **iomap** to deal with the VFS write out of pages back to
> +backing store, that is to help deal with a filesystems's ``struct
> +address_space_operations.writepages()``. The special ``iomap_writepages()`` is
> +used for this case with its own respective filestems's ``struct iomap_ops`` for
> +this.
> +
> +iomap for VFS llseek
> +--------------------
> +
> +A filesystem ``struct address_space_operations.llseek()`` is used by the VFS
> +when it needs to move the current file offset, the file offset is in ``struct

                                          offset;
or
                                          offset. The

> +file.f_pos``. **iomap** has special support for the ``llseek`` ``SEEK_HOLE`` or
> +``SEEK_DATA`` interfaces:
> +
> + * ``iomap_seek_hole()``: for when the
> +   ``struct address_space_operations.llseek()`` *whence* argument is
> +   ``SEEK_HOLE``, when looking for the file's next hole.
> + * ``iomap_seek_data()``: for when the
> +   ``struct address_space_operations.llseek()`` *whence* argument isj

                                                                     is

> +   ``SEEK_DATA`` when looking for the file's next data area.
> +
> +Your own ``struct iomap_ops`` for this is encouraged.
> +
> +iomap for DAX
> +-------------
> +You can use ``dax_iomap_rw()`` when calling iomap from a DAX context, this is

                                                                context. This is

> +typically from the filesystems's ``struct file_operations.write_iter()``
> +callback.
> +
> +Converting filesystems from buffer-head to iomap guide
> +======================================================
> +
> +These are generic guidelines on converting a filesystem over to **iomap** from
> +'''buffer-heads'''.
> +
> +One op at at time
> +-----------------
> +
> +You may try to convert a filesystem with different clustered set of operations> +at time, below are a generic order you may strive to target:

  on at a time. Below is

> +
> + * direct io

             IO

> + * miscellaneous helpers (seek/fiemap/bmap)
> + * buffered io

               IO

> +
> +Defining a simple filesystem
> +----------------------------
> +
> +A simple filesystem is perhaps the easiest to convert over to **iomap**, a

                                                                 **iomap**. A

> +simple filesystem is one which:
> +
> + * does not use fsverify, fscrypt, compression
> + * has no Copy on Write support (reflinks)
> +
> +Converting a simple filesystem to iomap
> +---------------------------------------
> +
> +Simple filesystems should covert to IOMAP piecemeal wise first converting over

                                                       wise, first

> +**direct IO**, then the miscellaneous helpers  (seek/fiemap/bmap) and last

   No need for **..** on direct IO if not also used on buffered IO below.

s/  / /

> +should be buffered IO.
> +
> +Converting shared filesystem features
> +-------------------------------------
> +
> +Shared filesystems features such as fscrypt, compression, erasure coding, and
> +any other data transformations need to be ported to **iomap** first, as none of
> +the current **iomap** users require any of this functionality.
> +
> +Converting complex filesystems
> +------------------------------
> +
> +If your filesystem relies on any shared filesystem features mentioned above

                                                                         above,

> +those would need to be converted piecemeal wise. If reflinks are supported you

IMO "wise" is not needed here or above when piecemeal is use.

> +need to first ensure proper locking sanity in order to be able to address byte
> +ranges can be handled properly through **iomap** operations.  An example
> +filesystem where this work is taking place is btrfs.
> +
> +IOMAP_F_BUFFER_HEAD considerations
> +----------------------------------
> +
> +``IOMAP_F_BUFFER_HEAD`` won't be removed until we have all filesystem fully
> +converted away from **buffer-heads**, and this could be never.
> +
> +``IOMAP_F_BUFFER_HEAD`` should be avoided as a stepping stone / to port
> +filesystems over to **iomap** as it's support for **buffer-heads** only apply to

                                    its                                    applies to

> +the buffered write path and nothing else including the read_folio/readahead and
> +writepages aops.
> +
> +Testing Direct IO
> +=================
> +
> +Other than fstests you can use LTP's dio, however this tests is limited as it

                                        dio. However, this test

> +does not test stale data.
> +
> +{{{
> +./runltp -f dio -d /mnt1/scratch/tmp/
> +}}}
> +
> +Known issues and future improvements
> +====================================
> +
> +We try to document known issues that folks should be aware of with **iomap** here.
> +
> + * write amplification on IOMAP when bs < ps: **iomap** needs improvements for

Is that buffer size < page size?  Preferably don't use such cryptic abbreviations.

> +   large folios for dirty bitmap tracking
> + * filesystems which use buffer head helpers such as ``sb_bread()`` and friends
> +   will have to continue to use buffer heads as there is no generic iomap
> +   metadata read/write library yet.
> +
> +References
> +==========
> +
> +  *  `Presentation on iomap evolution`<https://docs.google.com/presentation/d/e/2PACX-1vSN4TmhiTu1c6HNv6_gJZFqbFZpbF7GkABllSwJw5iLnSYKkkO-etQJ3AySYEbgJA/pub?start=true&loop=false&delayms=3000&slide=id.g189cfd05063_0_185>`
> +  * `LWN review on deprecating buffer-heads <https://lwn.net/Articles/930173/>`
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e2b836c2e119..ee4b026995ac 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -10,6 +10,30 @@
>  #include <linux/mm_types.h>
>  #include <linux/blkdev.h>
>  
> +/**
> + * DOC: Introduction
> + *
> + * iomap allows filesystems to sequentially iterate over byte addressable block
> + * ranges on an inode and apply operations to it.
> + *
> + * iomap grew out of the need to provide a modern block mapping abstraction for
> + * filesystems with the different IO access methods they support and assisting
> + * the VFS with manipulating files into the page cache. iomap helpers are
> + * provided for each of these mechanisms. However, block mapping is just one of
> + * the features of iomap, given iomap supports DAX IO for filesystems and also
> + * supports such the ``lseek``/``llseek`` ``SEEK_DATA``/``SEEK_HOLE``
> + * interfaces.
> + *
> + * Block mapping provides a mapping between data cached in memory and the
> + * location on persistent storage where that data lives. `LWN has an great
> + * review of the old buffer-heads block-mapping and why they are inefficient
> + * <https://lwn.net/Articles/930173/>`, since the inception of Linux.  Since
> + * **buffer-heads** work on a 512-byte block based paradigm, it creates an

                                          block-based

> + * overhead for modern storage media which no longer necessarily works only on
> + * 512-blocks. iomap is flexible providing block ranges in *bytes*. iomap, with

      512-byte blocks.

> + * the support of folios, provides a modern replacement for **buffer-heads**.
> + */
> +
>  struct address_space;
>  struct fiemap_extent_info;
>  struct inode;
> @@ -22,37 +46,43 @@ struct page;
>  struct vm_area_struct;
>  struct vm_fault;
>  
> -/*
> - * Types of block ranges for iomap mappings:
> +/**
> + * DOC: iomap block ranges types
> + *
> + * * IOMAP_HOLE		- no blocks allocated, need allocation
> + * * IOMAP_DELALLOC	- delayed allocation blocks
> + * * IOMAP_MAPPED	- blocks allocated at @addr
> + * * IOMAP_UNWRITTEN	- blocks allocated at @addr in unwritten state
> + * * IOMAP_INLINE	- data inline in the inode
>   */
> -#define IOMAP_HOLE	0	/* no blocks allocated, need allocation */
> -#define IOMAP_DELALLOC	1	/* delayed allocation blocks */
> -#define IOMAP_MAPPED	2	/* blocks allocated at @addr */
> -#define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
> -#define IOMAP_INLINE	4	/* data inline in the inode */
> +#define IOMAP_HOLE	0
> +#define IOMAP_DELALLOC	1
> +#define IOMAP_MAPPED	2
> +#define IOMAP_UNWRITTEN	3
> +#define IOMAP_INLINE	4
>  
> -/*
> - * Flags reported by the file system from iomap_begin:
> +/**
> + * DOC:  Flags reported by the file system from iomap_begin
>   *
> - * IOMAP_F_NEW indicates that the blocks have been newly allocated and need
> - * zeroing for areas that no data is copied to.
> + * * IOMAP_F_NEW: indicates that the blocks have been newly allocated and need
> + *	zeroing for areas that no data is copied to.
>   *
> - * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
> - * written data and requires fdatasync to commit them to persistent storage.
> - * This needs to take into account metadata changes that *may* be made at IO
> - * completion, such as file size updates from direct IO.
> + * * IOMAP_F_DIRTY: indicates the inode has uncommitted metadata needed to access
> + *	written data and requires fdatasync to commit them to persistent storage.
> + *	This needs to take into account metadata changes that *may* be made at IO
> + *	completion, such as file size updates from direct IO.
>   *
> - * IOMAP_F_SHARED indicates that the blocks are shared, and will need to be
> - * unshared as part a write.
> + * * IOMAP_F_SHARED: indicates that the blocks are shared, and will need to be
> + *	unshared as part a write.
>   *
> - * IOMAP_F_MERGED indicates that the iomap contains the merge of multiple block
> - * mappings.
> + * * IOMAP_F_MERGED: indicates that the iomap contains the merge of multiple
> + *	block mappings.
>   *
> - * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
> - * buffer heads for this mapping.
> + * * IOMAP_F_BUFFER_HEAD: indicates that the file system requires the use of
> + *	buffer heads for this mapping.
>   *
> - * IOMAP_F_XATTR indicates that the iomap is for an extended attribute extent
> - * rather than a file data extent.
> + * * IOMAP_F_XATTR: indicates that the iomap is for an extended attribute extent
> + *	rather than a file data extent.
>   */
>  #define IOMAP_F_NEW		(1U << 0)
>  #define IOMAP_F_DIRTY		(1U << 1)
> @@ -61,22 +91,20 @@ struct vm_fault;
>  #define IOMAP_F_BUFFER_HEAD	(1U << 4)
>  #define IOMAP_F_XATTR		(1U << 5)
>  
> -/*
> - * Flags set by the core iomap code during operations:
> +/**
> + * DOC: Flags set by the core iomap code during operations
> + *
> + * * IOMAP_F_SIZE_CHANGED: indicates to the iomap_end method that the file size
> + *	has changed as the result of this write operation.
>   *
> - * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
> - * has changed as the result of this write operation.
> + * * IOMAP_F_STALE: indicates that the iomap is not valid any longer and the file
> + *	range it covers needs to be remapped by the high level before the
> + *	operation can proceed.
>   *
> - * IOMAP_F_STALE indicates that the iomap is not valid any longer and the file
> - * range it covers needs to be remapped by the high level before the operation
> - * can proceed.
> + * * IOMAP_F_PRIVATE: Flags from 0x1000 up are for file system specific usage
>   */
>  #define IOMAP_F_SIZE_CHANGED	(1U << 8)
>  #define IOMAP_F_STALE		(1U << 9)
> -
> -/*
> - * Flags from 0x1000 up are for file system specific usage:
> - */
>  #define IOMAP_F_PRIVATE		(1U << 12)
>  
>  
> @@ -124,73 +152,119 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>  	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
>  }
>  
> -/*
> - * When a filesystem sets folio_ops in an iomap mapping it returns, get_folio
> - * and put_folio will be called for each folio written to.  This only applies
> - * to buffered writes as unbuffered writes will not typically have folios
> - * associated with them.
> - *
> - * When get_folio succeeds, put_folio will always be called to do any
> - * cleanup work necessary.  put_folio is responsible for unlocking and putting
> - * @folio.
> +/**
> + * struct iomap_folio_ops - buffered writes folio folio reference count helpers

                                               double folio?

> + *
> + * A filesystem can optionally set folio_ops in a &struct iomap mapping it
> + * returns to override the default get_folio and put_folio for each folio
> + * written to.  This only applies to buffered writes as unbuffered writes will
> + * not typically have folios associated with them.
> + *
> + * @get_folio: iomap defaults to iomap_get_folio() (which calls
> + *	__filemap_get_folio()) if the filesystem did not provide a get folio op.
> + *
> + * @put_folio: when get_folio succeeds, put_folio will always be called to do
> + *	any cleanup work necessary. put_folio is responsible for unlocking and
> + *	putting @folio.
> + *
> + * @iomap_valid: check that the cached iomap still maps correctly to the
> + *	filesystem's internal extent map. FS internal extent maps can change
> + *	while iomap is iterating a cached iomap, so this hook allows iomap to
> + *	detect that the iomap needs to be refreshed during a long running write operation.
> + *
> + *	The filesystem can store internal state (e.g. a sequence number) in
> + *	iomap->validity_cookie when the iomap is first mapped to be able to
> + *	detect changes between mapping time and whenever .iomap_valid() is
> + *	called.
> + *
> + *	This is called with the folio over the specified file position held
> + *	locked by the iomap code.  This is useful for filesystems that have
> + *	dynamic mappings (e.g. anything other than zonefs).  An example reason
> + *	as to why this is necessary is writeback doesn't take the vfs locks.

                                                                  VFS

>   */
>  struct iomap_folio_ops {
>  	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
>  			unsigned len);
>  	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
>  			struct folio *folio);
> -
> -	/*
> -	 * Check that the cached iomap still maps correctly to the filesystem's
> -	 * internal extent map. FS internal extent maps can change while iomap
> -	 * is iterating a cached iomap, so this hook allows iomap to detect that
> -	 * the iomap needs to be refreshed during a long running write
> -	 * operation.
> -	 *
> -	 * The filesystem can store internal state (e.g. a sequence number) in
> -	 * iomap->validity_cookie when the iomap is first mapped to be able to
> -	 * detect changes between mapping time and whenever .iomap_valid() is
> -	 * called.
> -	 *
> -	 * This is called with the folio over the specified file position held
> -	 * locked by the iomap code.
> -	 */
>  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
>  };
>  
> -/*
> - * Flags for iomap_begin / iomap_end.  No flag implies a read.
> +/**
> + * DOC:  Flags for iomap_begin / iomap_end.  No flag implies a read.
> + *
> + * * IOMAP_WRITE: writing, must allocate blocks
> + * * IOMAP_ZERO: zeroing operation, may skip holes
> + * * IOMAP_REPORT: report extent status, e.g. FIEMAP
> + * * IOMAP_FAULT: mapping for page fault
> + * * IOMAP_DIRECT: direct I/O
> + * * IOMAP_NOWAIT: do not block
> + * * IOMAP_OVERWRITE_ONLY: only pure overwrites allowed
> + * * IOMAP_UNSHARE: unshare_file_range
> + * * IOMAP_DAX: DAX mapping
>   */
> -#define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
> -#define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
> -#define IOMAP_REPORT		(1 << 2) /* report extent status, e.g. FIEMAP */
> -#define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
> -#define IOMAP_DIRECT		(1 << 4) /* direct I/O */
> -#define IOMAP_NOWAIT		(1 << 5) /* do not block */
> -#define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
> -#define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
> +#define IOMAP_WRITE		(1 << 0)
> +#define IOMAP_ZERO		(1 << 1)
> +#define IOMAP_REPORT		(1 << 2)
> +#define IOMAP_FAULT		(1 << 3)
> +#define IOMAP_DIRECT		(1 << 4)
> +#define IOMAP_NOWAIT		(1 << 5)
> +#define IOMAP_OVERWRITE_ONLY	(1 << 6)
> +#define IOMAP_UNSHARE		(1 << 7)
>  #ifdef CONFIG_FS_DAX
> -#define IOMAP_DAX		(1 << 8) /* DAX mapping */
> +#define IOMAP_DAX		(1 << 8)
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
>  
> +/**
> + * struct iomap_ops - IO interface specific operations
> + *
> + * A filesystem is must provide a &struct iomap_ops for to deal with the

s/is //
s/for //
s/the//

> + * beginning an IO operation, iomap_begin(), and ending an IO operation on as

                                                                              a

> + * block range, ``iomap_end()``. You would call iomap with a specialized iomap
> + * operation depending on its filesystem or the VFS needs.
> + *
> + * For example iomap_dio_rw() would be used for for a filesystem when doing a

                                               double for
checkpatch should have caught that.

> + * block range read or write operation with direct IO. In this case your
> + * filesystem's respective &struct file_operations.write_iter() would eventually
> + * call iomap_dio_rw() on the filesystem's &struct file_operations.write_iter().
> + *
> + * For buffered IO a filesystem would use iomap_file_buffered_write() on the
> + * same &struct file_operations.write_iter(). But that is not the only situation
> + * in which a filesystem would deal with buffered writes, you could also use

                                                     writes. You

> + * buffered writes when a filesystem has to deal with &struct
> + * file_operations.fallocate(). However fallocate() can be used for *zeroing* or

                                   However,

> + * for *truncation* purposes. A special respective iomap_zero_range() would be
> + * used for *zeroing* and a iomap_truncate_page() would be used for

                         and an

> + * *truncation*.
> + *
> + * Experience with adopting iomap on filesystems have shown that the filesystem

                                                    has

> + * implementation of these operations can be simplified considerably if one
> + * &struct iomap_ops is provided per major filesystem IO operation:
> + *
> + * * buffered io

                 IO

> + * * direct io

               IO

> + * * DAX io

            IO

> + * * fiemap for with extended attributes (``FIEMAP_FLAG_XATTR``)
> + * * lseek
> + *
> + * @iomap_begin: return the existing mapping at pos, or reserve space starting
> + *	at pos for up to length, as long as we can do it as a single mapping. The
> + *	actual length is returned in iomap->length. The &struct iomap iomap must
> + *	always be set. The &struct iomap srcmap should be set if the range is
> + *	CoW.
> + *
> + * @iomap_end: commit and/or unreserve space previous allocated using
> + *	iomap_begin. Written indicates the length of the successful write
> + *	operation which needs to be committed, while the rest needs to be
> + *	unreserved. Written might be zero if no data was written.
> + */
>  struct iomap_ops {
> -	/*
> -	 * Return the existing mapping at pos, or reserve space starting at
> -	 * pos for up to length, as long as we can do it as a single mapping.
> -	 * The actual length is returned in iomap->length.
> -	 */
>  	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
>  			unsigned flags, struct iomap *iomap,
>  			struct iomap *srcmap);
>  
> -	/*
> -	 * Commit and/or unreserve space previous allocated using iomap_begin.
> -	 * Written indicates the length of the successful write operation which
> -	 * needs to be commited, while the rest needs to be unreserved.
> -	 * Written might be zero if no data was written.
> -	 */
>  	int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
>  			ssize_t written, unsigned flags, struct iomap *iomap);
>  };
> @@ -207,6 +281,7 @@ struct iomap_ops {
>   * @flags: Zero or more of the iomap_begin flags above.
>   * @iomap: Map describing the I/O iteration
>   * @srcmap: Source map for COW operations
> + * @private: internal use
>   */
>  struct iomap_iter {
>  	struct inode *inode;
> @@ -241,7 +316,7 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
>   * @i: iteration structure
>   *
>   * Write operations on file systems with reflink support might require a
> - * source and a destination map.  This function retourns the source map
> + * source and a destination map.  This function returns the source map
>   * for a given operation, which may or may no be identical to the destination
>   * map in &i->iomap.
>   */
> @@ -281,42 +356,52 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
>  sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>  		const struct iomap_ops *ops);
>  
> -/*
> - * Structure for writeback I/O completions.
> +/**
> + * struct iomap_ioend - for writeback I/O completions
> + *
> + * @io_list: next ioend in chain
> + * @io_type:

missing field description.

> + * @io_flags: IOMAP_F_*
> + * @io_folios: folios added to ioend
> + * @io_inode: file being written to
> + * @io_size: size of the extent
> + * @io_offset: offset in the file
> + * @io_sector: start sector of ioend
> + * @io_bio: bio being built
> + * @io_inline_bio: MUST BE LAST!
>   */
>  struct iomap_ioend {
> -	struct list_head	io_list;	/* next ioend in chain */
> +	struct list_head	io_list;
>  	u16			io_type;
> -	u16			io_flags;	/* IOMAP_F_* */
> -	u32			io_folios;	/* folios added to ioend */
> -	struct inode		*io_inode;	/* file being written to */
> -	size_t			io_size;	/* size of the extent */
> -	loff_t			io_offset;	/* offset in the file */
> -	sector_t		io_sector;	/* start sector of ioend */
> -	struct bio		*io_bio;	/* bio being built */
> -	struct bio		io_inline_bio;	/* MUST BE LAST! */
> +	u16			io_flags;
> +	u32			io_folios;
> +	struct inode		*io_inode;
> +	size_t			io_size;
> +	loff_t			io_offset
> +	sector_t		io_sector;
> +	struct bio		*io_bio;
> +	struct bio		io_inline_bio;
>  };
>  
> +/**
> + * struct iomap_writeback_ops - used for writeback
> + *
> + * This structure is used to support dealing with a filesystem
> + * ``struct address_space_operations.writepages()``, for writeback.
> + *
> + * @map_blocks: required, maps the blocks so that writeback can be performed on
> + *	the range starting at offset.
> + * @prepare_ioend: optional, allows the file systems to perform actions just
> + *	before submitting the bio and/or override the bio end_io handler for
> + *	complex operations like copy on write extent manipulation or unwritten
> + *	extent conversions.
> + * @discard_folio: optional, allows the file system to discard state on a page where
> + *	we failed to submit any I/O.
> + */
>  struct iomap_writeback_ops {
> -	/*
> -	 * Required, maps the blocks so that writeback can be performed on
> -	 * the range starting at offset.
> -	 */
>  	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
>  				loff_t offset);
> -
> -	/*
> -	 * Optional, allows the file systems to perform actions just before
> -	 * submitting the bio and/or override the bio end_io handler for complex
> -	 * operations like copy on write extent manipulation or unwritten extent
> -	 * conversions.
> -	 */
>  	int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
> -
> -	/*
> -	 * Optional, allows the file system to discard state on a page where
> -	 * we failed to submit any I/O.
> -	 */
>  	void (*discard_folio)(struct folio *folio, loff_t pos);
>  };
>  
> @@ -334,26 +419,33 @@ int iomap_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops);
>  
> -/*
> - * Flags for direct I/O ->end_io:
> +/**
> + * DOC: Flags for direct I/O ->end_io
> + *
> + * * IOMAP_DIO_UNWRITTEN: covers unwritten extent(s)
> + * * IOMAP_DIO_COW: covers COW extent(s)
>   */
> -#define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
> -#define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
> +#define IOMAP_DIO_UNWRITTEN	(1 << 0)
> +#define IOMAP_DIO_COW		(1 << 1)
>  
> +/**
> + * struct iomap_dio_ops - used for direct IO
> + *
> + * This is used to support direct IO.
> + *
> + * @end_io:
> + * @submit_io:

missing field descriptions.

> + * @bio_set: Filesystems wishing to attach private information to a direct io

                                                                              IO

> + *	bio must provide a ->submit_io method that attaches the additional
> + *	information to the bio and changes the ->bi_end_io callback to a custom
> + *	function.  This function should, at a minimum, perform any relevant
> + *	post-processing of the bio and end with a call to iomap_dio_bio_end_io.
> + */
>  struct iomap_dio_ops {
>  	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
>  		      unsigned flags);
>  	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
>  		          loff_t file_offset);
> -
> -	/*
> -	 * Filesystems wishing to attach private information to a direct io bio
> -	 * must provide a ->submit_io method that attaches the additional
> -	 * information to the bio and changes the ->bi_end_io callback to a
> -	 * custom function.  This function should, at a minimum, perform any
> -	 * relevant post-processing of the bio and end with a call to
> -	 * iomap_dio_bio_end_io.
> -	 */
>  	struct bio_set *bio_set;
>  };
>  


Thanks for doing all this work.

-- 
~Randy
