Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71743A66E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhFNMso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 08:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhFNMsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:48:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1C6C061574;
        Mon, 14 Jun 2021 05:46:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g142so15231113ybf.9;
        Mon, 14 Jun 2021 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0ntc4/AXda6pDtryZB5M+kjYfLi4Bfi0CoUR2uChqk=;
        b=clileFeEHt1W1AS2ccYRUVkoZ/7t7W4SeXZKmuvoZ/gpQaV6iipx8N/s/jx8QwUSfB
         iJr8K4TKZX/C8biY5zFOUsEDwjv9AOZ8EhzjIkAtVqKmcQoBBdRl9GuBiz627eMCo4PH
         TUpy7LbxwHUTAWilCPtWoUAS2aHe2cRFRQzFubSqNTzozlK3x8R8BseOr7d7Wra5cEkz
         d6wDopjIadOvzXAhEh+vJ/v9Bn/bW73Hbj0Bpbhxn3rA2rnTzamNzmW//6uQ3b3M8qtw
         9bz5nSY5PuenwcQPHl5gYIgDUXv1v+v5WHZEpYR3+WtYhFN4bFENcqQGSd7Kjmjs8qVr
         21Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0ntc4/AXda6pDtryZB5M+kjYfLi4Bfi0CoUR2uChqk=;
        b=q8q+IBoEVYkvo04Y/CAtVK8YcCjk4/YAznuofbbZoLGDiMNUogw/IwZnQqg6yZIldp
         pbJLvg5+8gewO9UxMkV8JQWKQOY6yJdmCLrRzxLiDrAE+UDct1IAkXuHHmJEnHiiyn8Z
         1n1VMjk1SQ+cOSBaFDPGT0BMjUPVdRqaGlF1fXwURwTVrbCCLwxlV3VhVQKa5JFS36Gf
         Ej17sI3ExOiBFwB0pIc9tWZEiQ3Mqp/rjkF/8UDdyimd454v0wkfUao4Y6sD7Up/QwdV
         Nyn7wNMPiMojbSGshjv+s6bJW2b7AERMRWmQTo6F4J8S4LxIbfassUxP3eJvkzXPKddy
         XBIA==
X-Gm-Message-State: AOAM530V7imdN0KhAY92ft+BOAWHs+AIMqP9TvsqNAWiHzlsYefJ2eDA
        Lh+WIVT8/4wKWluCaGshQBHsgbNbrPHz/EEzHa0=
X-Google-Smtp-Source: ABdhPJwsWPGrThDvQXuJpxJqKC8QtuTiEi3Dq1o4NGL93SKL9RuM6Xl3CjjuTRG9Hzkn07zYxv0FPWDIROiDjUlsd9w=
X-Received: by 2002:a25:3089:: with SMTP id w131mr4374686ybw.34.1623674782956;
 Mon, 14 Jun 2021 05:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <270998.1612265397@warthog.procyon.org.uk>
In-Reply-To: <270998.1612265397@warthog.procyon.org.uk>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Mon, 14 Jun 2021 18:16:11 +0530
Message-ID: <CANT5p=o3uvY0MB8Ftf6_17qMp0GKKebLb-QHv4rHayAQJNo7eA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Rough, incomplete conversion to revised fscache I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Steven French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 2, 2021 at 5:03 PM David Howells <dhowells@redhat.com> wrote:
>
> Hi Steve,
>
> Here's a rough, but incomplete, conversion of cifs to use the revised fscache
> I/O API and the netfs helper lib, but I've about hit the limit of what I can
> manage to do.  It's built on top of my fscache-netfs-lib branch:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib
>
> Notes:
>
>  (*) I've replaced some code to discard data by reading into a big buffer with
>      code that uses the ITER_DISCARD iterator instead.  See
>      cifs_discard_from_socket().
>
>  (*) I've tried to make the ordinary read use an ITER_XARRAY iterator and read
>      into that directly from the socket, rather than looping through a bunch
>      of pages.  This will handle THPs and partial pages for you.  However,
>      under some circumstances, readpages_fill_pages() would then be reading
>      from an iterator to an iterator, it appears.  Possibly the source
>      iterator can be got rid of, but the code is quite complex.
>
>  (*) There's a new function, cifs_req_issue_op(), which the netfs helpers use
>      to issue a read on part of a request.  This looks at current->tgid, but
>      might be running on a workqueue, so needs to get the tgid from somewhere
>      else if not CIFS_MOUNT_RWPIDFORWARD.
>
>  (*) cifs_readpage(), cifs_readahead() and cifs_write_begin() now go through
>      the helpers.  cifs_readpages() is obsolete and is removed.
>
>  (*) At the completion of a read, netfs_subreq_terminated() is called.  As a
>      future optimisation, we can add a function to do incremental advancement
>      of the pages, unlocking them as we go.  The issue is, however, that we
>      have to coordinate with writing larger page lumps to the cache.
>
>  (*) The clause in cifs_write_begin() about optimising away a read when we
>      have an oplock needs dealing with, but I'm not sure how to fit it in.
>
> David
> ---
> diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
> index fe03cbdae959..ad296c3dbd04 100644
> --- a/fs/cifs/Kconfig
> +++ b/fs/cifs/Kconfig
> @@ -2,6 +2,7 @@
>  config CIFS
>         tristate "SMB3 and CIFS support (advanced network filesystem)"
>         depends on INET
> +       select NETFS_SUPPORT
>         select NLS
>         select CRYPTO
>         select CRYPTO_MD4
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 50fcb65920e8..fe5fd4bcb866 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1283,6 +1283,7 @@ struct cifs_readdata;
>
>  /* asynchronous read support */
>  struct cifs_readdata {
> +       struct netfs_read_subrequest    *subreq;
>         struct kref                     refcount;
>         struct list_head                list;
>         struct completion               done;
> @@ -1301,6 +1302,7 @@ struct cifs_readdata {
>         int (*copy_into_pages)(struct TCP_Server_Info *server,
>                                 struct cifs_readdata *rdata,
>                                 struct iov_iter *iter);
> +       struct iov_iter                 iter;
>         struct kvec                     iov[2];
>         struct TCP_Server_Info          *server;
>  #ifdef CONFIG_CIFS_SMB_DIRECT
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index 340ff81ee87b..f5ac4a7c1cfc 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -230,11 +230,16 @@ extern unsigned int setup_special_user_owner_ACE(struct cifs_ace *pace);
>  extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
>  extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
>                                  unsigned int to_read);
> +extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
> +                                       size_t to_read);
>  extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
>                                         struct page *page,
>                                         unsigned int page_offset,
>                                         unsigned int to_read);
>  extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
> +extern int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
> +                                     struct iov_iter *iter,
> +                                     unsigned int to_read);
>  extern int cifs_match_super(struct super_block *, void *);
>  extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
>  extern void cifs_umount(struct cifs_sb_info *);
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 0496934feecb..671afc822afc 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -36,6 +36,7 @@
>  #include <linux/swap.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/uaccess.h>
> +#include <linux/netfs.h>
>  #include "cifspdu.h"
>  #include "cifsglob.h"
>  #include "cifsacl.h"
> @@ -1445,15 +1446,15 @@ int
>  cifs_discard_remaining_data(struct TCP_Server_Info *server)
>  {
>         unsigned int rfclen = server->pdu_size;
> -       int remaining = rfclen + server->vals->header_preamble_size -
> +       size_t remaining = rfclen + server->vals->header_preamble_size -
>                 server->total_read;
>
>         while (remaining > 0) {
> -               int length;
> +               ssize_t length;
>
> -               length = cifs_read_from_socket(server, server->bigbuf,
> -                               min_t(unsigned int, remaining,
> -                                   CIFSMaxBufSize + MAX_HEADER_SIZE(server)));
> +               length = cifs_discard_from_socket(server,
> +                               min_t(size_t, remaining,
> +                                     CIFSMaxBufSize + MAX_HEADER_SIZE(server)));
>                 if (length < 0)
>                         return length;
>                 server->total_read += length;
> @@ -1664,7 +1665,14 @@ cifs_readv_callback(struct mid_q_entry *mid)
>                 rdata->result = -EIO;
>         }
>
> -       queue_work(cifsiod_wq, &rdata->work);
> +       if (rdata->subreq) {
> +               netfs_subreq_terminated(rdata->subreq,
> +                                       (rdata->result == 0 || rdata->result == -EAGAIN) ?
> +                                       rdata->got_bytes : rdata->result);
> +               kref_put(&rdata->refcount, cifs_readdata_release);
> +       } else {
> +               queue_work(cifsiod_wq, &rdata->work);
> +       }
>         DeleteMidQEntry(mid);
>         add_credits(server, &credits, 0);
>  }
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 5d39129406ea..28c13602ed43 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -564,6 +564,15 @@ cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
>         return cifs_readv_from_socket(server, &smb_msg);
>  }
>
> +ssize_t
> +cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_read)
> +{
> +       struct msghdr smb_msg;
> +       iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
> +
> +       return cifs_readv_from_socket(server, &smb_msg);
> +}
> +
>  int
>  cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
>         unsigned int page_offset, unsigned int to_read)
> @@ -575,6 +584,22 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
>         return cifs_readv_from_socket(server, &smb_msg);
>  }
>
> +int
> +cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct iov_iter *iter,
> +                          unsigned int to_read)
> +{
> +       struct msghdr smb_msg;
> +       int ret;
> +
> +       smb_msg.msg_iter = *iter;
> +       if (smb_msg.msg_iter.count > to_read)
> +               smb_msg.msg_iter.count = to_read;
> +       ret = cifs_readv_from_socket(server, &smb_msg);
> +       if (ret > 0)
> +               iov_iter_advance(iter, ret);
> +       return ret;
> +}
> +
>  static bool
>  is_smb_response(struct TCP_Server_Info *server, unsigned char type)
>  {
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 6d001905c8e5..c1f7ad4dbcb9 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -34,6 +34,7 @@
>  #include <linux/slab.h>
>  #include <linux/swap.h>
>  #include <linux/mm.h>
> +#include <linux/netfs.h>
>  #include <asm/div64.h>
>  #include "cifsfs.h"
>  #include "cifspdu.h"
> @@ -4006,98 +4007,6 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
>         return rc;
>  }
>
> -static ssize_t
> -cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
> -{
> -       int rc = -EACCES;
> -       unsigned int bytes_read = 0;
> -       unsigned int total_read;
> -       unsigned int current_read_size;
> -       unsigned int rsize;
> -       struct cifs_sb_info *cifs_sb;
> -       struct cifs_tcon *tcon;
> -       struct TCP_Server_Info *server;
> -       unsigned int xid;
> -       char *cur_offset;
> -       struct cifsFileInfo *open_file;
> -       struct cifs_io_parms io_parms = {0};
> -       int buf_type = CIFS_NO_BUFFER;
> -       __u32 pid;
> -
> -       xid = get_xid();
> -       cifs_sb = CIFS_FILE_SB(file);
> -
> -       /* FIXME: set up handlers for larger reads and/or convert to async */
> -       rsize = min_t(unsigned int, cifs_sb->ctx->rsize, CIFSMaxBufSize);
> -
> -       if (file->private_data == NULL) {
> -               rc = -EBADF;
> -               free_xid(xid);
> -               return rc;
> -       }
> -       open_file = file->private_data;
> -       tcon = tlink_tcon(open_file->tlink);
> -       server = cifs_pick_channel(tcon->ses);
> -
> -       if (!server->ops->sync_read) {
> -               free_xid(xid);
> -               return -ENOSYS;
> -       }
> -
> -       if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
> -               pid = open_file->pid;
> -       else
> -               pid = current->tgid;
> -
> -       if ((file->f_flags & O_ACCMODE) == O_WRONLY)
> -               cifs_dbg(FYI, "attempting read on write only file instance\n");
> -
> -       for (total_read = 0, cur_offset = read_data; read_size > total_read;
> -            total_read += bytes_read, cur_offset += bytes_read) {
> -               do {
> -                       current_read_size = min_t(uint, read_size - total_read,
> -                                                 rsize);
> -                       /*
> -                        * For windows me and 9x we do not want to request more
> -                        * than it negotiated since it will refuse the read
> -                        * then.
> -                        */
> -                       if (!(tcon->ses->capabilities &
> -                               tcon->ses->server->vals->cap_large_files)) {
> -                               current_read_size = min_t(uint,
> -                                       current_read_size, CIFSMaxBufSize);
> -                       }
> -                       if (open_file->invalidHandle) {
> -                               rc = cifs_reopen_file(open_file, true);
> -                               if (rc != 0)
> -                                       break;
> -                       }
> -                       io_parms.pid = pid;
> -                       io_parms.tcon = tcon;
> -                       io_parms.offset = *offset;
> -                       io_parms.length = current_read_size;
> -                       io_parms.server = server;
> -                       rc = server->ops->sync_read(xid, &open_file->fid, &io_parms,
> -                                                   &bytes_read, &cur_offset,
> -                                                   &buf_type);
> -               } while (rc == -EAGAIN);
> -
> -               if (rc || (bytes_read == 0)) {
> -                       if (total_read) {
> -                               break;
> -                       } else {
> -                               free_xid(xid);
> -                               return rc;
> -                       }
> -               } else {
> -                       cifs_stats_bytes_read(tcon, total_read);
> -                       *offset += bytes_read;
> -               }
> -       }
> -       free_xid(xid);
> -       return total_read;
> -}
> -
>  /*
>   * If the page is mmap'ed into a process' page tables, then we need to make
>   * sure that it doesn't change while being written back.
> @@ -4107,7 +4016,21 @@ cifs_page_mkwrite(struct vm_fault *vmf)
>  {
>         struct page *page = vmf->page;
>
> -       lock_page(page);
> +       /* Wait for the page to be written to the cache before we allow it to
> +        * be modified.  We then assume the entire page will need writing back.
> +        */
> +#ifdef CONFIG_CIFS_FSCACHE
> +       if (PageFsCache(page) &&
> +           wait_on_page_bit_killable(page, PG_fscache) < 0)
> +               return VM_FAULT_RETRY;
> +#endif
> +
> +       if (PageWriteback(page) &&
> +           wait_on_page_bit_killable(page, PG_writeback) < 0)
> +               return VM_FAULT_RETRY;
> +
> +       if (lock_page_killable(page) < 0)
> +               return VM_FAULT_RETRY;
>         return VM_FAULT_LOCKED;
>  }
>
> @@ -4154,39 +4077,6 @@ int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
>         return rc;
>  }
>
> -static void
> -cifs_readv_complete(struct work_struct *work)
> -{
> -       unsigned int i, got_bytes;
> -       struct cifs_readdata *rdata = container_of(work,
> -                                               struct cifs_readdata, work);
> -
> -       got_bytes = rdata->got_bytes;
> -       for (i = 0; i < rdata->nr_pages; i++) {
> -               struct page *page = rdata->pages[i];
> -
> -               lru_cache_add(page);
> -
> -               if (rdata->result == 0 ||
> -                   (rdata->result == -EAGAIN && got_bytes)) {
> -                       flush_dcache_page(page);
> -                       SetPageUptodate(page);
> -               }
> -
> -               unlock_page(page);
> -
> -               if (rdata->result == 0 ||
> -                   (rdata->result == -EAGAIN && got_bytes))
> -                       cifs_readpage_to_fscache(rdata->mapping->host, page);
> -
> -               got_bytes -= min_t(unsigned int, PAGE_SIZE, got_bytes);
> -
> -               put_page(page);
> -               rdata->pages[i] = NULL;
> -       }
> -       kref_put(&rdata->refcount, cifs_readdata_release);
> -}
> -
>  static int
>  readpages_fill_pages(struct TCP_Server_Info *server,
>                      struct cifs_readdata *rdata, struct iov_iter *iter,
> @@ -4261,8 +4151,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
>                         result = n;
>  #endif
>                 else
> -                       result = cifs_read_page_from_socket(
> -                                       server, page, page_offset, n);
> +                       result = cifs_read_iter_from_socket(server, &rdata->iter, n);
>                 if (result < 0)
>                         break;
>
> @@ -4288,292 +4177,179 @@ cifs_readpages_copy_into_pages(struct TCP_Server_Info *server,
>         return readpages_fill_pages(server, rdata, iter, iter->count);
>  }
>
> -static int
> -readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
> -                   unsigned int rsize, struct list_head *tmplist,
> -                   unsigned int *nr_pages, loff_t *offset, unsigned int *bytes)
> -{
> -       struct page *page, *tpage;
> -       unsigned int expected_index;
> -       int rc;
> -       gfp_t gfp = readahead_gfp_mask(mapping);
> -
> -       INIT_LIST_HEAD(tmplist);
> -
> -       page = lru_to_page(page_list);
> -
> -       /*
> -        * Lock the page and put it in the cache. Since no one else
> -        * should have access to this page, we're safe to simply set
> -        * PG_locked without checking it first.
> -        */
> -       __SetPageLocked(page);
> -       rc = add_to_page_cache_locked(page, mapping,
> -                                     page->index, gfp);
> -
> -       /* give up if we can't stick it in the cache */
> -       if (rc) {
> -               __ClearPageLocked(page);
> -               return rc;
> -       }
> -
> -       /* move first page to the tmplist */
> -       *offset = (loff_t)page->index << PAGE_SHIFT;
> -       *bytes = PAGE_SIZE;
> -       *nr_pages = 1;
> -       list_move_tail(&page->lru, tmplist);
> -
> -       /* now try and add more pages onto the request */
> -       expected_index = page->index + 1;
> -       list_for_each_entry_safe_reverse(page, tpage, page_list, lru) {
> -               /* discontinuity ? */
> -               if (page->index != expected_index)
> -                       break;
> -
> -               /* would this page push the read over the rsize? */
> -               if (*bytes + PAGE_SIZE > rsize)
> -                       break;
> -
> -               __SetPageLocked(page);
> -               rc = add_to_page_cache_locked(page, mapping, page->index, gfp);
> -               if (rc) {
> -                       __ClearPageLocked(page);
> -                       break;
> -               }
> -               list_move_tail(&page->lru, tmplist);
> -               (*bytes) += PAGE_SIZE;
> -               expected_index++;
> -               (*nr_pages)++;
> -       }
> -       return rc;
> -}
> -
> -static int cifs_readpages(struct file *file, struct address_space *mapping,
> -       struct list_head *page_list, unsigned num_pages)
> +/*
> + * Issue a read operation on behalf of the netfs helper functions.  We're asked
> + * to make a read of a certain size at a point in the file.  We are permitted
> + * to only read a portion of that, but as long as we read something, the netfs
> + * helper will call us again so that we can issue another read.
> + */
> +static void cifs_req_issue_op(struct netfs_read_subrequest *subreq)
>  {
> -       int rc;
> -       int err = 0;
> -       struct list_head tmplist;
> -       struct cifsFileInfo *open_file = file->private_data;
> -       struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(file);
> +       struct netfs_read_request *rreq = subreq->rreq;
>         struct TCP_Server_Info *server;
> -       pid_t pid;
> +       struct cifs_readdata *rdata;
> +       struct cifsFileInfo *open_file = rreq->netfs_priv;
> +       struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
> +       struct cifs_credits credits_on_stack, *credits = &credits_on_stack;
>         unsigned int xid;
> +       pid_t pid;
> +       int rc;
> +       unsigned int rsize;
>
>         xid = get_xid();
> -       /*
> -        * Reads as many pages as possible from fscache. Returns -ENOBUFS
> -        * immediately if the cookie is negative
> -        *
> -        * After this point, every page in the list might have PG_fscache set,
> -        * so we will need to clean that up off of every page we don't use.
> -        */
> -       rc = cifs_readpages_from_fscache(mapping->host, mapping, page_list,
> -                                        &num_pages);
> -       if (rc == 0) {
> -               free_xid(xid);
> -               return rc;
> -       }
>
>         if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
>                 pid = open_file->pid;
>         else
>                 pid = current->tgid;
> +#warning current might be a workqueue
>
>         rc = 0;
>         server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
>
> -       cifs_dbg(FYI, "%s: file=%p mapping=%p num_pages=%u\n",
> -                __func__, file, mapping, num_pages);
> -
> -       /*
> -        * Start with the page at end of list and move it to private
> -        * list. Do the same with any following pages until we hit
> -        * the rsize limit, hit an index discontinuity, or run out of
> -        * pages. Issue the async read and then start the loop again
> -        * until the list is empty.
> -        *
> -        * Note that list order is important. The page_list is in
> -        * the order of declining indexes. When we put the pages in
> -        * the rdata->pages, then we want them in increasing order.
> -        */
> -       while (!list_empty(page_list) && !err) {
> -               unsigned int i, nr_pages, bytes, rsize;
> -               loff_t offset;
> -               struct page *page, *tpage;
> -               struct cifs_readdata *rdata;
> -               struct cifs_credits credits_on_stack;
> -               struct cifs_credits *credits = &credits_on_stack;
> +       cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
> +                __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
> +                subreq->transferred, subreq->len);
>
> -               if (open_file->invalidHandle) {
> +       if (open_file->invalidHandle) {
> +               do {
>                         rc = cifs_reopen_file(open_file, true);
> -                       if (rc == -EAGAIN)
> -                               continue;
> -                       else if (rc)
> -                               break;
> -               }
> -
> -               rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
> -                                                  &rsize, credits);
> +               } while (rc == -EAGAIN);
>                 if (rc)
> -                       break;
> -
> -               /*
> -                * Give up immediately if rsize is too small to read an entire
> -                * page. The VFS will fall back to readpage. We should never
> -                * reach this point however since we set ra_pages to 0 when the
> -                * rsize is smaller than a cache page.
> -                */
> -               if (unlikely(rsize < PAGE_SIZE)) {
> -                       add_credits_and_wake_if(server, credits, 0);
> -                       free_xid(xid);
> -                       return 0;
> -               }
> -
> -               nr_pages = 0;
> -               err = readpages_get_pages(mapping, page_list, rsize, &tmplist,
> -                                        &nr_pages, &offset, &bytes);
> -               if (!nr_pages) {
> -                       add_credits_and_wake_if(server, credits, 0);
> -                       break;
> -               }
> -
> -               rdata = cifs_readdata_alloc(nr_pages, cifs_readv_complete);
> -               if (!rdata) {
> -                       /* best to give up if we're out of mem */
> -                       list_for_each_entry_safe(page, tpage, &tmplist, lru) {
> -                               list_del(&page->lru);
> -                               lru_cache_add(page);
> -                               unlock_page(page);
> -                               put_page(page);
> -                       }
> -                       rc = -ENOMEM;
> -                       add_credits_and_wake_if(server, credits, 0);
> -                       break;
> -               }
> +                       goto out;
> +       }
>
> -               rdata->cfile = cifsFileInfo_get(open_file);
> -               rdata->server = server;
> -               rdata->mapping = mapping;
> -               rdata->offset = offset;
> -               rdata->bytes = bytes;
> -               rdata->pid = pid;
> -               rdata->pagesz = PAGE_SIZE;
> -               rdata->tailsz = PAGE_SIZE;
> -               rdata->read_into_pages = cifs_readpages_read_into_pages;
> -               rdata->copy_into_pages = cifs_readpages_copy_into_pages;
> -               rdata->credits = credits_on_stack;
> +       rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize, credits);
> +       if (rc)
> +               goto out;
>
> -               list_for_each_entry_safe(page, tpage, &tmplist, lru) {
> -                       list_del(&page->lru);
> -                       rdata->pages[rdata->nr_pages++] = page;
> -               }
> +       rdata = cifs_readdata_alloc(0, NULL);
> +       if (!rdata) {
> +               rc = -ENOMEM;
> +               add_credits_and_wake_if(server, credits, 0);
> +               goto out;
> +       }
>
> -               rc = adjust_credits(server, &rdata->credits, rdata->bytes);
> +       rdata->subreq = subreq;
> +       rdata->cfile = cifsFileInfo_get(open_file);
> +       rdata->server = server;
> +       rdata->mapping = rreq->mapping;
> +       rdata->offset = subreq->start + subreq->transferred;
> +       rdata->bytes = subreq->len   - subreq->transferred;
> +       rdata->pid = pid;
> +       rdata->pagesz = PAGE_SIZE;
> +       rdata->tailsz = PAGE_SIZE;
> +       rdata->read_into_pages = cifs_readpages_read_into_pages;
> +       rdata->copy_into_pages = cifs_readpages_copy_into_pages;
> +       rdata->credits = credits_on_stack;
>
> -               if (!rc) {
> -                       if (rdata->cfile->invalidHandle)
> -                               rc = -EAGAIN;
> -                       else
> -                               rc = server->ops->async_readv(rdata);
> -               }
> +       iov_iter_xarray(&rdata->iter, READ, &rreq->mapping->i_pages,
> +                       rdata->offset, rdata->bytes);
>
> -               if (rc) {
> -                       add_credits_and_wake_if(server, &rdata->credits, 0);
> -                       for (i = 0; i < rdata->nr_pages; i++) {
> -                               page = rdata->pages[i];
> -                               lru_cache_add(page);
> -                               unlock_page(page);
> -                               put_page(page);
> -                       }
> -                       /* Fallback to the readpage in error/reconnect cases */
> -                       kref_put(&rdata->refcount, cifs_readdata_release);
> -                       break;
> -               }
> +       rc = adjust_credits(server, &rdata->credits, rdata->bytes);
> +       if (!rc) {
> +               if (rdata->cfile->invalidHandle)
> +                       rc = -EAGAIN;
> +               else
> +                       rc = server->ops->async_readv(rdata);
> +       }
>
> +       if (rc) {
> +               add_credits_and_wake_if(server, &rdata->credits, 0);
> +               /* Fallback to the readpage in error/reconnect cases */
>                 kref_put(&rdata->refcount, cifs_readdata_release);
>         }
>
> -       /* Any pages that have been shown to fscache but didn't get added to
> -        * the pagecache must be uncached before they get returned to the
> -        * allocator.
> -        */
> -       cifs_fscache_readpages_cancel(mapping->host, page_list);
> +       kref_put(&rdata->refcount, cifs_readdata_release);
> +
> +out:
>         free_xid(xid);
> -       return rc;
> +       if (rc < 0)
> +               netfs_subreq_terminated(subreq, rc);
>  }
>
> -/*
> - * cifs_readpage_worker must be called with the page pinned
> - */
> -static int cifs_readpage_worker(struct file *file, struct page *page,
> -       loff_t *poffset)
> +static void cifs_init_rreq(struct netfs_read_request *rreq, struct file *file)
>  {
> -       char *read_data;
> -       int rc;
> -
> -       /* Is the page cached? */
> -       rc = cifs_readpage_from_fscache(file_inode(file), page);
> -       if (rc == 0)
> -               goto read_complete;
> +       rreq->netfs_priv = file->private_data;
> +}
>
> -       read_data = kmap(page);
> -       /* for reads over a certain size could initiate async read ahead */
> +static bool cifs_is_cache_enabled(struct inode *inode)
> +{
> +       struct fscache_cookie *cookie = cifs_inode_cookie(inode);
>
> -       rc = cifs_read(file, read_data, PAGE_SIZE, poffset);
> +       return fscache_cookie_enabled(cookie) && !hlist_empty(&cookie->backing_objects);
> +}
>
> -       if (rc < 0)
> -               goto io_error;
> -       else
> -               cifs_dbg(FYI, "Bytes read %d\n", rc);
> +static int cifs_begin_cache_operation(struct netfs_read_request *rreq)
> +{
> +       return fscache_begin_read_operation(rreq, cifs_inode_cookie(rreq->inode));
> +}
>
> -       /* we do not want atime to be less than mtime, it broke some apps */
> -       file_inode(file)->i_atime = current_time(file_inode(file));
> -       if (timespec64_compare(&(file_inode(file)->i_atime), &(file_inode(file)->i_mtime)))
> -               file_inode(file)->i_atime = file_inode(file)->i_mtime;
> -       else
> -               file_inode(file)->i_atime = current_time(file_inode(file));
> +/*
> + * Expand the size of a readahead to the size of the rsize, if at least as
> + * large as a page, allowing for the possibility that rsize is not pow-2
> + * aligned.  The caller will then clamp it to i_size.
> + */
> +static void cifs_expand_readahead(struct netfs_read_request *rreq)
> +{
> +       struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
> +       unsigned int rsize = cifs_sb->ctx->rsize;
> +       loff_t misalignment;
>
> -       if (PAGE_SIZE > rc)
> -               memset(read_data + rc, 0, PAGE_SIZE - rc);
> +       if (rsize < PAGE_SIZE)
> +               return;
>
> -       flush_dcache_page(page);
> -       SetPageUptodate(page);
> +       if (rsize < INT_MAX)
> +               rsize = roundup_pow_of_two(rsize);
> +       else
> +               rsize = ((unsigned int)INT_MAX + 1) / 2;
>
> -       /* send this page to the cache */
> -       cifs_readpage_to_fscache(file_inode(file), page);
> +       misalignment = rreq->start & (rsize - 1);
> +       if (misalignment) {
> +               rreq->start -= misalignment;
> +               rreq->len += misalignment;
> +       }
>
> -       rc = 0;
> +       rreq->len = round_up(rreq->len, rsize);
> +}
>
> -io_error:
> -       kunmap(page);
> -       unlock_page(page);
> +static void cifs_rreq_done(struct netfs_read_request *rreq)
> +{
> +       struct inode *inode = rreq->inode;
>
> -read_complete:
> -       return rc;
> +       /* we do not want atime to be less than mtime, it broke some apps */
> +       inode->i_atime = current_time(inode);
> +       if (timespec64_compare(&inode->i_atime, &inode->i_mtime))
> +               inode->i_atime = inode->i_mtime;
> +       else
> +               inode->i_atime = current_time(inode);
>  }
>
> +const struct netfs_read_request_ops cifs_req_ops = {
> +       .init_rreq              = cifs_init_rreq,
> +       .is_cache_enabled       = cifs_is_cache_enabled,
> +       .begin_cache_operation  = cifs_begin_cache_operation,
> +       .expand_readahead       = cifs_expand_readahead,
> +       .issue_op               = cifs_req_issue_op,
> +       .done                   = cifs_rreq_done,
> +};
> +
>  static int cifs_readpage(struct file *file, struct page *page)
>  {
>         loff_t offset = (loff_t)page->index << PAGE_SHIFT;
> -       int rc = -EACCES;
> -       unsigned int xid;
> -
> -       xid = get_xid();
>
> -       if (file->private_data == NULL) {
> -               rc = -EBADF;
> -               free_xid(xid);
> -               return rc;
> -       }
> +       if (!file->private_data)
> +               return -EBADF;
>
> -       cifs_dbg(FYI, "readpage %p at offset %d 0x%x\n",
> -                page, (int)offset, (int)offset);
> +       cifs_dbg(FYI, "readpage %p at offset %u 0x%x\n",
> +                page, (unsigned int)offset, (int)offset);
>
> -       rc = cifs_readpage_worker(file, page, &offset);
> +       return netfs_readpage(file, page, &cifs_req_ops, NULL);
> +}
>
> -       free_xid(xid);
> -       return rc;
> +static void cifs_readahead(struct readahead_control *ractl)
> +{
> +       netfs_readahead(ractl, &cifs_req_ops, NULL);
>  }
>
>  static int is_inode_writable(struct cifsInodeInfo *cifs_inode)
> @@ -4625,34 +4401,21 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
>                         loff_t pos, unsigned len, unsigned flags,
>                         struct page **pagep, void **fsdata)
>  {
> -       int oncethru = 0;
> -       pgoff_t index = pos >> PAGE_SHIFT;
> -       loff_t offset = pos & (PAGE_SIZE - 1);
> -       loff_t page_start = pos & PAGE_MASK;
> -       loff_t i_size;
>         struct page *page;
> -       int rc = 0;
> +       int rc;
>
>         cifs_dbg(FYI, "write_begin from %lld len %d\n", (long long)pos, len);
>
> -start:
> -       page = grab_cache_page_write_begin(mapping, index, flags);
> -       if (!page) {
> -               rc = -ENOMEM;
> -               goto out;
> -       }
> -
> -       if (PageUptodate(page))
> -               goto out;
> -
> -       /*
> -        * If we write a full page it will be up to date, no need to read from
> -        * the server. If the write is short, we'll end up doing a sync write
> -        * instead.
> +       /* Prefetch area to be written into the cache if we're caching this
> +        * file.  We need to do this before we get a lock on the page in case
> +        * there's more than one writer competing for the same cache block.
>          */
> -       if (len == PAGE_SIZE)
> -               goto out;
> +       rc = netfs_write_begin(file, mapping, pos, len, flags, &page, fsdata,
> +                              &cifs_req_ops, NULL);
> +       if (rc < 0)
> +               return rc;
>
> +#if 0
>         /*
>          * optimize away the read when we have an oplock, and we're not
>          * expecting to use any of the data we'd be reading in. That
> @@ -4676,25 +4439,8 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
>                         goto out;
>                 }
>         }
> -
> -       if ((file->f_flags & O_ACCMODE) != O_WRONLY && !oncethru) {
> -               /*
> -                * might as well read a page, it is fast enough. If we get
> -                * an error, we don't need to return it. cifs_write_end will
> -                * do a sync write instead since PG_uptodate isn't set.
> -                */
> -               cifs_readpage_worker(file, page, &page_start);
> -               put_page(page);
> -               oncethru = 1;
> -               goto start;
> -       } else {
> -               /* we could try using another file handle if there is one -
> -                  but how would we lock it to prevent close of that handle
> -                  racing with this read? In any case
> -                  this will be written out by write_end so is fine */
> -       }
> -out:
> -       *pagep = page;
> +#endif
> +       *pagep = find_subpage(page, pos / PAGE_SIZE);
>         return rc;
>  }
>
> @@ -4703,16 +4449,23 @@ static int cifs_release_page(struct page *page, gfp_t gfp)
>         if (PagePrivate(page))
>                 return 0;
>
> -       return cifs_fscache_release_page(page, gfp);
> +       /* deny if page is being written to the cache and the caller hasn't
> +        * elected to wait */
> +#ifdef CONFIG_CIFS_FSCACHE
> +       if (PageFsCache(page)) {
> +               if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
> +                       return 0;
> +               wait_on_page_fscache(page);
> +       }
> +#endif
> +
> +       return 1;
>  }
>
>  static void cifs_invalidate_page(struct page *page, unsigned int offset,
>                                  unsigned int length)
>  {
> -       struct cifsInodeInfo *cifsi = CIFS_I(page->mapping->host);
> -
> -       if (offset == 0 && length == PAGE_SIZE)
> -               cifs_fscache_invalidate_page(page, &cifsi->vfs_inode);
> +       wait_on_page_fscache(page);
>  }
>
>  static int cifs_launder_page(struct page *page)
> @@ -4732,7 +4485,7 @@ static int cifs_launder_page(struct page *page)
>         if (clear_page_dirty_for_io(page))
>                 rc = cifs_writepage_locked(page, &wbc);
>
> -       cifs_fscache_invalidate_page(page, page->mapping->host);
> +       wait_on_page_fscache(page);
>         return rc;
>  }
>
> @@ -4872,7 +4625,7 @@ static void cifs_swap_deactivate(struct file *file)
>
>  const struct address_space_operations cifs_addr_ops = {
>         .readpage = cifs_readpage,
> -       .readpages = cifs_readpages,
> +       .readahead = cifs_readahead,
>         .writepage = cifs_writepage,
>         .writepages = cifs_writepages,
>         .write_begin = cifs_write_begin,
> diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
> index 20d24af33ee2..4acd599d91d9 100644
> --- a/fs/cifs/fscache.c
> +++ b/fs/cifs/fscache.c
> @@ -199,7 +199,6 @@ static void cifs_fscache_disable_inode_cookie(struct inode *inode)
>
>         if (cifsi->fscache) {
>                 cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cifsi->fscache);
> -               fscache_uncache_all_inode_pages(cifsi->fscache, inode);
>                 fscache_relinquish_cookie(cifsi->fscache, NULL, true);
>                 cifsi->fscache = NULL;
>         }
> @@ -229,120 +228,3 @@ void cifs_fscache_reset_inode_cookie(struct inode *inode)
>                          __func__, cifsi->fscache, old);
>         }
>  }
> -
> -int cifs_fscache_release_page(struct page *page, gfp_t gfp)
> -{
> -       if (PageFsCache(page)) {
> -               struct inode *inode = page->mapping->host;
> -               struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -
> -               cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
> -                        __func__, page, cifsi->fscache);
> -               if (!fscache_maybe_release_page(cifsi->fscache, page, gfp))
> -                       return 0;
> -       }
> -
> -       return 1;
> -}
> -
> -static void cifs_readpage_from_fscache_complete(struct page *page, void *ctx,
> -                                               int error)
> -{
> -       cifs_dbg(FYI, "%s: (0x%p/%d)\n", __func__, page, error);
> -       if (!error)
> -               SetPageUptodate(page);
> -       unlock_page(page);
> -}
> -
> -/*
> - * Retrieve a page from FS-Cache
> - */
> -int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
> -{
> -       int ret;
> -
> -       cifs_dbg(FYI, "%s: (fsc:%p, p:%p, i:0x%p\n",
> -                __func__, CIFS_I(inode)->fscache, page, inode);
> -       ret = fscache_read_or_alloc_page(CIFS_I(inode)->fscache, page,
> -                                        cifs_readpage_from_fscache_complete,
> -                                        NULL,
> -                                        GFP_KERNEL);
> -       switch (ret) {
> -
> -       case 0: /* page found in fscache, read submitted */
> -               cifs_dbg(FYI, "%s: submitted\n", __func__);
> -               return ret;
> -       case -ENOBUFS:  /* page won't be cached */
> -       case -ENODATA:  /* page not in cache */
> -               cifs_dbg(FYI, "%s: %d\n", __func__, ret);
> -               return 1;
> -
> -       default:
> -               cifs_dbg(VFS, "unknown error ret = %d\n", ret);
> -       }
> -       return ret;
> -}
> -
> -/*
> - * Retrieve a set of pages from FS-Cache
> - */
> -int __cifs_readpages_from_fscache(struct inode *inode,
> -                               struct address_space *mapping,
> -                               struct list_head *pages,
> -                               unsigned *nr_pages)
> -{
> -       int ret;
> -
> -       cifs_dbg(FYI, "%s: (0x%p/%u/0x%p)\n",
> -                __func__, CIFS_I(inode)->fscache, *nr_pages, inode);
> -       ret = fscache_read_or_alloc_pages(CIFS_I(inode)->fscache, mapping,
> -                                         pages, nr_pages,
> -                                         cifs_readpage_from_fscache_complete,
> -                                         NULL,
> -                                         mapping_gfp_mask(mapping));
> -       switch (ret) {
> -       case 0: /* read submitted to the cache for all pages */
> -               cifs_dbg(FYI, "%s: submitted\n", __func__);
> -               return ret;
> -
> -       case -ENOBUFS:  /* some pages are not cached and can't be */
> -       case -ENODATA:  /* some pages are not cached */
> -               cifs_dbg(FYI, "%s: no page\n", __func__);
> -               return 1;
> -
> -       default:
> -               cifs_dbg(FYI, "unknown error ret = %d\n", ret);
> -       }
> -
> -       return ret;
> -}
> -
> -void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
> -{
> -       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -       int ret;
> -
> -       cifs_dbg(FYI, "%s: (fsc: %p, p: %p, i: %p)\n",
> -                __func__, cifsi->fscache, page, inode);
> -       ret = fscache_write_page(cifsi->fscache, page,
> -                                cifsi->vfs_inode.i_size, GFP_KERNEL);
> -       if (ret != 0)
> -               fscache_uncache_page(cifsi->fscache, page);
> -}
> -
> -void __cifs_fscache_readpages_cancel(struct inode *inode, struct list_head *pages)
> -{
> -       cifs_dbg(FYI, "%s: (fsc: %p, i: %p)\n",
> -                __func__, CIFS_I(inode)->fscache, inode);
> -       fscache_readpages_cancel(CIFS_I(inode)->fscache, pages);
> -}
> -
> -void __cifs_fscache_invalidate_page(struct page *page, struct inode *inode)
> -{
> -       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -       struct fscache_cookie *cookie = cifsi->fscache;
> -
> -       cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
> -       fscache_wait_on_page_write(cookie, page);
> -       fscache_uncache_page(cookie, page);
> -}
> diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
> index e811f2dd7619..b86ef0fcf676 100644
> --- a/fs/cifs/fscache.h
> +++ b/fs/cifs/fscache.h
> @@ -21,6 +21,7 @@
>  #ifndef _CIFS_FSCACHE_H
>  #define _CIFS_FSCACHE_H
>
> +#define FSCACHE_USE_NEW_IO_API
>  #include <linux/fscache.h>
>
>  #include "cifsglob.h"
> @@ -70,56 +71,9 @@ extern void cifs_fscache_release_inode_cookie(struct inode *);
>  extern void cifs_fscache_set_inode_cookie(struct inode *, struct file *);
>  extern void cifs_fscache_reset_inode_cookie(struct inode *);
>
> -extern void __cifs_fscache_invalidate_page(struct page *, struct inode *);
> -extern int cifs_fscache_release_page(struct page *page, gfp_t gfp);
> -extern int __cifs_readpage_from_fscache(struct inode *, struct page *);
> -extern int __cifs_readpages_from_fscache(struct inode *,
> -                                        struct address_space *,
> -                                        struct list_head *,
> -                                        unsigned *);
> -extern void __cifs_fscache_readpages_cancel(struct inode *, struct list_head *);
> -
> -extern void __cifs_readpage_to_fscache(struct inode *, struct page *);
> -
> -static inline void cifs_fscache_invalidate_page(struct page *page,
> -                                              struct inode *inode)
> -{
> -       if (PageFsCache(page))
> -               __cifs_fscache_invalidate_page(page, inode);
> -}
> -
> -static inline int cifs_readpage_from_fscache(struct inode *inode,
> -                                            struct page *page)
> -{
> -       if (CIFS_I(inode)->fscache)
> -               return __cifs_readpage_from_fscache(inode, page);
> -
> -       return -ENOBUFS;
> -}
> -
> -static inline int cifs_readpages_from_fscache(struct inode *inode,
> -                                             struct address_space *mapping,
> -                                             struct list_head *pages,
> -                                             unsigned *nr_pages)
> -{
> -       if (CIFS_I(inode)->fscache)
> -               return __cifs_readpages_from_fscache(inode, mapping, pages,
> -                                                    nr_pages);
> -       return -ENOBUFS;
> -}
> -
> -static inline void cifs_readpage_to_fscache(struct inode *inode,
> -                                           struct page *page)
> -{
> -       if (PageFsCache(page))
> -               __cifs_readpage_to_fscache(inode, page);
> -}
> -
> -static inline void cifs_fscache_readpages_cancel(struct inode *inode,
> -                                                struct list_head *pages)
> +static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
>  {
> -       if (CIFS_I(inode)->fscache)
> -               return __cifs_fscache_readpages_cancel(inode, pages);
> +       return CIFS_I(inode)->fscache;
>  }
>
>  #else /* CONFIG_CIFS_FSCACHE */
> @@ -138,34 +92,8 @@ static inline void cifs_fscache_release_inode_cookie(struct inode *inode) {}
>  static inline void cifs_fscache_set_inode_cookie(struct inode *inode,
>                                                  struct file *filp) {}
>  static inline void cifs_fscache_reset_inode_cookie(struct inode *inode) {}
> -static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
> -{
> -       return 1; /* May release page */
> -}
> -
> -static inline void cifs_fscache_invalidate_page(struct page *page,
> -                       struct inode *inode) {}
> -static inline int
> -cifs_readpage_from_fscache(struct inode *inode, struct page *page)
> -{
> -       return -ENOBUFS;
> -}
>
> -static inline int cifs_readpages_from_fscache(struct inode *inode,
> -                                             struct address_space *mapping,
> -                                             struct list_head *pages,
> -                                             unsigned *nr_pages)
> -{
> -       return -ENOBUFS;
> -}
> -
> -static inline void cifs_readpage_to_fscache(struct inode *inode,
> -                       struct page *page) {}
> -
> -static inline void cifs_fscache_readpages_cancel(struct inode *inode,
> -                                                struct list_head *pages)
> -{
> -}
> +static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
>
>  #endif /* CONFIG_CIFS_FSCACHE */
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 794fc3b68b4f..788b5a364365 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -36,6 +36,7 @@
>  #include <linux/uuid.h>
>  #include <linux/pagemap.h>
>  #include <linux/xattr.h>
> +#include <linux/netfs.h>
>  #include "smb2pdu.h"
>  #include "cifsglob.h"
>  #include "cifsacl.h"
> @@ -3984,7 +3985,14 @@ smb2_readv_callback(struct mid_q_entry *mid)
>                                      tcon->tid, tcon->ses->Suid,
>                                      rdata->offset, rdata->got_bytes);
>
> -       queue_work(cifsiod_wq, &rdata->work);
> +       if (rdata->subreq) {
> +               netfs_subreq_terminated(rdata->subreq,
> +                                       (rdata->result == 0 || rdata->result == -EAGAIN) ?
> +                                       rdata->got_bytes : rdata->result);
> +               kref_put(&rdata->refcount, cifs_readdata_release);
> +       } else {
> +               queue_work(cifsiod_wq, &rdata->work);
> +       }
>         DeleteMidQEntry(mid);
>         add_credits(server, &credits, 0);
>  }
>

Hi David,

I went through the above changes. Overall, the new netfs helper APIs
do appear to make things a lot easier for the netfs.

However, I see that you've thrown away the old way to control
invalidation/release of fscache pages for an inode and replaced them
with a wait on the page's fscache bit.
Wouldn't fscache benefit from knowing the pages that are no longer
necessary? Don't we need to tell fscache that the pages are no longer
needed?

And how can a netfs request the fscache to flush all the dirty pages
for an inode?
The reason being that the data is still dirty, as long as it is not
written to the server.
For various reasons, cifs.ko may need to know that all the dirty data
for an inode is written back to the server, before proceeding.

-- 
Regards,
Shyam
