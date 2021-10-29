Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9943F70B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 08:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhJ2GRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 02:17:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39004 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJ2GRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:17:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CA2721968;
        Fri, 29 Oct 2021 06:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635488112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E919aeXK8dC3N34MDRziiU6STn2FmtpVBAk+ecOLJjo=;
        b=rHi5YhKLU0rlCRHyPeKnauDRrrKyNolq7E6F6dDcjkjrYygp8K9iGOEHJj1sMmsNmnFoqm
        JXUgJyq68i9P1XXycPxZOj9RRmHZ61CddjBbgHSqzeBEgXTEn3O/eT1/pGQOrrjanxFKqN
        Ws1Xa0M9ZepgclsMvVLPpSC9aP/pzDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635488112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E919aeXK8dC3N34MDRziiU6STn2FmtpVBAk+ecOLJjo=;
        b=S6CjmYqZCZ0yYeJGy3BiUS6TxG8jiMGcenKddoe10AYo6bdOAQvrpluZxu5uvYpr7RJ4EU
        3KaNhyzDb7UqKtAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55C5313AF5;
        Fri, 29 Oct 2021 06:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ah71CW2Re2HXXAAAMHmgww
        (envelope-from <colyli@suse.de>); Fri, 29 Oct 2021 06:15:09 +0000
Message-ID: <b11bb34b-8fdf-b6ed-b305-e7145f2a7ab2@suse.de>
Date:   Fri, 29 Oct 2021 14:15:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: Readahead for compressed data
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        linux-bcache@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
From:   Coly Li <colyli@suse.de>
In-Reply-To: <YXHK5HrQpJu9oy8w@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/21 4:17 AM, Matthew Wilcox wrote:
> As far as I can tell, the following filesystems support compressed data:
>
> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs

Hi Matthew,

There is a new bcachefs mailing list linux-bcachefs@vger.kernel.org for 
bcachefs. I add it in Cc in this reply email.

Just FYI for you and other receivers.

Thanks.

Coly Li


>
> I'd like to make it easier and more efficient for filesystems to
> implement compressed data.  There are a lot of approaches in use today,
> but none of them seem quite right to me.  I'm going to lay out a few
> design considerations next and then propose a solution.  Feel free to
> tell me I've got the constraints wrong, or suggest alternative solutions.
>
> When we call ->readahead from the VFS, the VFS has decided which pages
> are going to be the most useful to bring in, but it doesn't know how
> pages are bundled together into blocks.  As I've learned from talking to
> Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> something we can teach the VFS.
>
> We (David) added readahead_expand() recently to let the filesystem
> opportunistically add pages to the page cache "around" the area requested
> by the VFS.  That reduces the number of times the filesystem has to
> decompress the same block.  But it can fail (due to memory allocation
> failures or pages already being present in the cache).  So filesystems
> still have to implement some kind of fallback.
>
> For many (all?) compression algorithms (all?) the data must be mapped at
> all times.  Calling kmap() and kunmap() would be an intolerable overhead.
> At the same time, we cannot write to a page in the page cache which is
> marked Uptodate.  It might be mapped into userspace, or a read() be in
> progress against it.  For writable filesystems, it might even be dirty!
> As far as I know, no compression algorithm supports "holes", implying
> that we must allocate memory which is then discarded.
>
> To me, this calls for a vmap() based approach.  So I'm thinking
> something like ...
>
> void *readahead_get_block(struct readahead_control *ractl, loff_t start,
> 			size_t len);
> void readahead_put_block(struct readahead_control *ractl, void *addr,
> 			bool success);
>
> Once you've figured out which bytes this encrypted block expands to, you
> call readahead_get_block(), specifying the offset in the file and length
> and get back a pointer.  When you're done decompressing that block of
> the file, you get rid of it again.
>
> It's the job of readahead_get_block() to allocate additional pages
> into the page cache or temporary pages.  readahead_put_block() will
> mark page cache pages as Uptodate if 'success' is true, and unlock
> them.  It'll free any temporary pages.
>
> Thoughts?  Anyone want to be the guinea pig?  ;-)

