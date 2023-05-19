Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76618709AFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjESPOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjESPOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:14:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD58198;
        Fri, 19 May 2023 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1opaetK90ziQPrltM/q7s99LS+5Ffz+3TEwjrEuHrv4=; b=q442WZBtQBcOW7sBrNoWDtaPsc
        NHZWvxl5JBj/nYxbbB5KkKy/mxxDzNWFPcemw/hWQn5t78rr0GaE+Lu/9EZaWnLYngq3LOvKoCGwu
        Rsuu1xpUADM5kH0dC/r3joANDzDtnPjHt4RWga/vgnXFEbJ5UeMWQkJC0addAPUGEog9i/vDLWsxJ
        3NOL5jZfsiDDGtqMu1bizMp9LRnvmhhZA9vGb2zo0CRL6MkZkLZ7wWFWuIZrp71D+zviky5bsJQL8
        f55Qy+XSsUGRTuDfBOKHbG3iwNOhf9N9I9lMJjG2QS51+qYMleuyEIz6y4CL102xxlRvySSXk1Khi
        M8f/yFYg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q01nj-00GZpF-2b;
        Fri, 19 May 2023 15:13:51 +0000
Message-ID: <731a3061-973c-a4ad-2fe5-7981c6c1279b@infradead.org>
Date:   Fri, 19 May 2023 08:13:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Documentation: add initial iomap kdoc
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net,
        jake@lwn.net, hch@infradead.org, djwong@kernel.org,
        dchinner@redhat.com
Cc:     ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
References: <20230518144037.3149361-1-mcgrof@kernel.org>
 <ZGdBO6bmbj3sLlzp@debian.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZGdBO6bmbj3sLlzp@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/19/23 02:28, Bagas Sanjaya wrote:
>> +/**
>> + * DOC:  Flags reported by the file system from iomap_begin
>>   *
>> - * IOMAP_F_NEW indicates that the blocks have been newly allocated and need
>> - * zeroing for areas that no data is copied to.
>> + * * IOMAP_F_NEW: indicates that the blocks have been newly allocated and need
>> + *	zeroing for areas that no data is copied to.
>>   *
>> - * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
>> - * written data and requires fdatasync to commit them to persistent storage.
>> - * This needs to take into account metadata changes that *may* be made at IO
>> - * completion, such as file size updates from direct IO.
>> + * * IOMAP_F_DIRTY: indicates the inode has uncommitted metadata needed to access
>> + *	written data and requires fdatasync to commit them to persistent storage.
>> + *	This needs to take into account metadata changes that *may* be made at IO
>> + *	completion, such as file size updates from direct IO.
>>   *
>> - * IOMAP_F_SHARED indicates that the blocks are shared, and will need to be
>> - * unshared as part a write.
>> + * * IOMAP_F_SHARED: indicates that the blocks are shared, and will need to be
>> + *	unshared as part a write.
>>   *
>> - * IOMAP_F_MERGED indicates that the iomap contains the merge of multiple block
>> - * mappings.
>> + * * IOMAP_F_MERGED: indicates that the iomap contains the merge of multiple block
>> + *	mappings.
>>   *
>> - * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
>> - * buffer heads for this mapping.
>> + * * IOMAP_F_BUFFER_HEAD: indicates that the file system requires the use of
>> + *	buffer heads for this mapping.
>>   *
>> - * IOMAP_F_XATTR indicates that the iomap is for an extended attribute extent
>> - * rather than a file data extent.
>> + * * IOMAP_F_XATTR: indicates that the iomap is for an extended attribute extent
>> + *	rather than a file data extent.
>>   */
> Why don't use kernel-doc comments to describe flags?
> 

Because kernel-doc handles functions, structs, unions, and enums.
Not defines.

-- 
~Randy
