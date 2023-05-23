Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19470D0D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 04:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjEWCLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 22:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEWCLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 22:11:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F7CA;
        Mon, 22 May 2023 19:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2AQoI84FFH+/Fdm9nLSd2Gkl/xoxZl6Bw2n3UB+cN7c=; b=qPl2RGWqPWaKjDPdadixjegOcU
        /ysHbUChVuHRO+PSUKHkUSyzRAvO7J+1IYRRyXQD75F6Aik0tTIINmtwGqx+mxVaIlkVhHecgC2Lt
        pRdYA5L+iaQmZ7LvfntYGG9scjuABB0LfCYanshacsfFVxNEYs8JoSquVvr2Lu2hb7nF2bM3gUKsk
        chldEmOzQ3Nkp4OVdeSLW9X0sRI6EMi+8H80G3GeNQ40TiXSyWZSLVpRR03mYR2p0aFya9yefadMf
        aj4dA3biK+sllbrRtXXR90TXJDiSEpmpdmRzey29cQlK7TkEpa8p15gkIx234J609+IAXjRLq2YAe
        YJ6R61gA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1HUv-008eRS-0L;
        Tue, 23 May 2023 02:11:37 +0000
Message-ID: <fb5c17bd-5e6a-ac68-8c6c-1bc67ed2af63@infradead.org>
Date:   Mon, 22 May 2023 19:11:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] Documentation: add initial iomap kdoc
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net, jake@lwn.net,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
References: <20230518150105.3160445-1-mcgrof@kernel.org>
 <ZGcDaysYl+w9kV6+@infradead.org> <20230523012028.GE11598@frogsfrogsfrogs>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230523012028.GE11598@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/22/23 18:20, Darrick J. Wong wrote:
> On Thu, May 18, 2023 at 10:04:43PM -0700, Christoph Hellwig wrote:
>> On Thu, May 18, 2023 at 08:01:05AM -0700, Luis Chamberlain wrote:
>>> +        Mapping of heading styles within this document:
>>> +        Heading 1 uses "====" above and below
>>> +        Heading 2 uses "===="
>>> +        Heading 3 uses "----"
>>> +        Heading 4 uses "````"
>>> +        Heading 5 uses "^^^^"
>>> +        Heading 6 uses "~~~~"
>>> +        Heading 7 uses "...."
>>> +
>>> +        Sections are manually numbered because apparently that's what everyone
>>
>> Why are you picking different defaults then the rest of the kernel
>> documentation?
> 
> I bet Luis copied that from the online fsck document.
> 
> IIRC the doc generator is smart enough to handle per-file heading usage.
> The rst parser sourcecode doesn't seem to have harcoded defaults; every
> time it sees an unfamiliar heading style in a .rst file, it adds that as
> the next level down in the hierarchy.
> 
> Also, where are the "proper" headings documented for Documentation/?

Documentation/doc-guide/sphinx.rst:

* Please stick to this order of heading adornments:

and following lines.

-- 
~Randy
