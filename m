Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E336766B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 15:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAUO2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 09:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUO2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:28:22 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D921A07;
        Sat, 21 Jan 2023 06:28:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70C3668CFE; Sat, 21 Jan 2023 15:28:16 +0100 (CET)
Date:   Sat, 21 Jan 2023 15:28:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 7/7] mm: return an ERR_PTR from __filemap_get_folio
Message-ID: <20230121142815.GA6786@lst.de>
References: <20230121065755.1140136-8-hch@lst.de> <202301211944.5T9l1RgA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301211944.5T9l1RgA-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 07:52:54PM +0800, kernel test robot wrote:
> Hi Christoph,
> 
> I love your patch! Perhaps something to improve:

And I don't love all this hugging when something doesn't work.  It feels
passive aggressive.

That being said, in this case the error is becaue the series is against
linux-next, so applying it to mainline won't work.

