Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92826794128
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjIFQG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbjIFQGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:06:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B121BE3;
        Wed,  6 Sep 2023 09:06:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F968C433CA;
        Wed,  6 Sep 2023 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694016382;
        bh=lfAEgspvs7GWXI/7tANzrKSA2TuvJ8XyM+cv1clYA28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPhV08FC9iPACQ4yB8m4tjq8xlbCAsuoURUrLmC88h6I8f1u35kxEN+5nxJ8U97iT
         bUSbZPZEOKY7B9/c6O7TPOFDN9wcuOq3kPSmrW5CQuQG5EECKQYQZHPn90ZR7VlVQn
         OkZaF30OLrFHKbnhRF1BHimGFHYJj23RQ7JOZ2Nc=
Date:   Wed, 6 Sep 2023 17:06:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com, Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v33 0/6] Implement IOCTL to get and optionally clear info
 about PTEs
Message-ID: <2023090630-remark-subsidy-7996@gregkh>
References: <20230821141518.870589-1-usama.anjum@collabora.com>
 <aab6585e-d650-4b00-9760-990f88382909@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab6585e-d650-4b00-9760-990f88382909@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:44:33PM +0500, Muhammad Usama Anjum wrote:
> Soft Reminder.

It's the middle of the merge window, none of us can add anything to any
tree at the moment until after -rc1 is out.  Please relax, there is no
deadline here, nor any rush.

If you want to help out, please start reviewing other changes in this
area that are pending on the mailing lists.

thanks,

greg k-h
