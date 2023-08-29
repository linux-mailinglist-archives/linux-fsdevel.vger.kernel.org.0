Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4644278CF04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 23:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbjH2V6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjH2V6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:58:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1920FD;
        Tue, 29 Aug 2023 14:57:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 272FB5C0258;
        Tue, 29 Aug 2023 17:57:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 29 Aug 2023 17:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693346279; x=1693432679; bh=pyw5d94QAnr8PZVn2x1/vPBbr481BfBpiMv
        3gEajRU4=; b=lvBOYEVHmIpwAhzXRE5EgVU+hRr/1GQcjFoeodfBnVH+RsdgLPC
        1AwYzBbVpoALqwIlhtSO5XyYAir1Aj4nHApJ+NVW05dLwIiI/fnaHLsH24J/FHXm
        KP47PsKBq0BbUD2ek/FlztESwqAI9XGHO8dQN9lDsrn65SDfyvqbhUa1TQfqc9Io
        T0WYXbS11TLHHQKy0aAPGhYm75xw7Am3Jf2rGWVptj1OYGbHjg91gUHREyFmCvPZ
        hq0dkausxIUoplf0lhcfe4UMSpuoXTEfj6cnKcRq768cjvtUNLoMnAfhNElCp8rq
        C9RrGeAYj3dwtskVerki+OhFAPN4qgitpGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693346279; x=1693432679; bh=pyw5d94QAnr8PZVn2x1/vPBbr481BfBpiMv
        3gEajRU4=; b=OjScocuZgjucGeOKxaTrn9u3hmarTaZsSvElTn7LRWUYtNy35qw
        HE4PgK9XgSNgPchg9zpifJHXZ2tWL16gCXF69lrSxwEUV0UbrhAsiYRDxAMtHkZy
        qY8WMPzN9HsnbuT+PFn8dZKUWuDPu1u4YpAOt29anK44GUOj1n6rTcW/BnocRBVe
        Y9T6QJVZUhwfN5Jz8lGtfeaV91Z2Ui3TuXqjqZOWHhuafgLdoTK0CxffcpYQnPoM
        FJpWfnpNNZUFu1DufesbhxXjnwliPiPORYnBBrwJGfCcMSceJOJN6BH/dceSqERu
        DJ48u+SItFivbfS0/zaC/4BPxfp/tzrP7Pw==
X-ME-Sender: <xms:5mnuZGQK2oFCzj1iazlI3jshjkq_sG9va2-uVe2LRvQ5VZ8XX6XYvg>
    <xme:5mnuZLxgUsPHLy7x_2ruLSmtdn-VBgkKi3NgW9tWWm1rBk_astItYR5_xszkIrAEk
    1TNM62zVcsQErhx>
X-ME-Received: <xmr:5mnuZD1wrFm--fukL1ZIoQuEWnvg69RjLcexcL_YM0ZZ1zZzb7nZ_5tB4iv4F-Q3VCzF-lq0rLXYka6szOyeAZO5GFjpSzmiNg8t5gLipgjPeGr7CjLy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:5mnuZCAEYr5qKbtaeTYN5xOLjmij9BAIkNkhnFCxfJP1RhLdaXXTfw>
    <xmx:5mnuZPhFNOlDk098yfTHTk9tCwG_bHAeWlkfcDPsyREw-2PMlynNQw>
    <xmx:5mnuZOo2pVP_BOgAcHectHoc-HFqxaxrTVCvHhbjV_tzPF57dp0JEQ>
    <xmx:52nuZMvP4ZBgbi4Tu_w_VaZOOvyknTVOUUbj-OsBaZrpVKoKaNV9LQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 17:57:57 -0400 (EDT)
Message-ID: <572dcce8-f70c-2d24-f844-a3e8abbd4bd8@fastmail.fm>
Date:   Tue, 29 Aug 2023 23:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
Content-Language: en-US, de-DE
To:     Lei Huang <lei.huang@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/29/23 20:36, Lei Huang wrote:
> Our user space filesystem relies on fuse to provide POSIX interface.
> In our test, a known string is written into a file and the content
> is read back later to verify correct data returned. We observed wrong
> data returned in read buffer in rare cases although correct data are
> stored in our filesystem.
> 
> Fuse kernel module calls iov_iter_get_pages2() to get the physical
> pages of the user-space read buffer passed in read(). The pages are
> not pinned to avoid page migration. When page migration occurs, the
> consequence are two-folds.
> 
> 1) Applications do not receive correct data in read buffer.
> 2) fuse kernel writes data into a wrong place.
> 
> Using iov_iter_extract_pages() to pin pages fixes the issue in our
> test.

Hmm, iov_iter_extract_pages does not exists for a long time and the code 
in fuse_get_user_pages didn't change much. So if you are right, there 
would be a long term data corruption for page migrations? And a back 
port to old kernels would not be obvious?

What confuses me further is that
commit 85dd2c8ff368 does not mention migration or corruption, although 
lists several other advantages for iov_iter_extract_pages. Other commits 
using iov_iter_extract_pages point to fork - i.e. would your data 
corruption be possibly related that?


Thanks,
Bernd


> 
> An auxiliary variable "struct page **pt_pages" is used in the patch
> to prepare the 2nd parameter for iov_iter_extract_pages() since
> iov_iter_get_pages2() uses a different type for the 2nd parameter.
> 
> Signed-off-by: Lei Huang <lei.huang@linux.intel.com>
> ---
>   fs/fuse/file.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bc41152..715de3b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -670,7 +670,7 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap,
>   	for (i = 0; i < ap->num_pages; i++) {
>   		if (should_dirty)
>   			set_page_dirty_lock(ap->pages[i]);
> -		put_page(ap->pages[i]);
> +		unpin_user_page(ap->pages[i]);
>   	}
>   }
>   
> @@ -1428,10 +1428,13 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>   	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
>   		unsigned npages;
>   		size_t start;
> -		ret = iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
> -					*nbytesp - nbytes,
> -					max_pages - ap->num_pages,
> -					&start);
> +		struct page **pt_pages;
> +
> +		pt_pages = &ap->pages[ap->num_pages];
> +		ret = iov_iter_extract_pages(ii, &pt_pages,
> +					     *nbytesp - nbytes,
> +					     max_pages - ap->num_pages,
> +					     0, &start);
>   		if (ret < 0)
>   			break;
>   
