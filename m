Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83D573636
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiGMMTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 08:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMMTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:19:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7DE1E;
        Wed, 13 Jul 2022 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mJjBmMAXT2h6I0nmMQuW56J/7RtTYtOpHF5Tj5AvOWE=; b=WMa19WfnzPViDLABSHs3QnQmSW
        4Yn9G+E+X+eHmXygmZ9SJISv+OjO4Uet8m9+0J8uKFMeGLXluy40BJGPVnAieJzm0fn+vmh5jDS9P
        d3JN2TlJCNWWpUL/PwQSv79shcoOlUdWO8TcM5BkVLX7NU45Y9z78/dU4PHkKFkcIexCFJs2m9R+R
        RG5tg4d9l0HcbjratWoNf9PCm/ofpp7zdYUZbpwPLjnqq6Y/iHgZMgpPulPD8LAUwZW4PtUZ390qa
        lAEs/1h8We8KTGbsylxYgERHE/pMWH+Lui46xp88dsXquY86RVjWfA5/O9QucoBk9BC5KebK2lgkR
        +dJ/tBoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBbKd-008Alv-T2; Wed, 13 Jul 2022 12:19:07 +0000
Date:   Wed, 13 Jul 2022 13:19:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk, agk@redhat.com,
        song@kernel.org, djwong@kernel.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com,
        jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
        danil.kipnis@cloud.ionos.com, ebiggers@google.com,
        jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH V2 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Ys64O6malGAbslBL@casper.infradead.org>
References: <20220713072019.5885-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713072019.5885-1-kch@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:20:13AM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> One of the responsibilities of the Operating System, along with managing
> resources, is to provide a unified interface to the user by creating
> hardware abstractions. In the Linux Kernel storage stack that
> abstraction is created by implementing the generic request operations
> such as REQ_OP_READ/REQ_OP_WRITE or REQ_OP_DISCARD/REQ_OP_WRITE_ZEROES,
> etc that are mapped to the specific low-level hardware protocol commands 
> e.g. SCSI or NVMe.

Still NAK, see previous thread for reasons.  Somewhat disappointing that
you sent a new version instead of addressing those comments first.
