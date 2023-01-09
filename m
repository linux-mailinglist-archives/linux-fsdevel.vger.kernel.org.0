Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC05662DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 19:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbjAISDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbjAISCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:02:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B56959FA9;
        Mon,  9 Jan 2023 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BCuu1Z0qbJBEbfj7CTHbZxsWM5NTOjpkHlVfssGqvpU=; b=l5D+VHrB1IyaVrP9Gip5NhWRKQ
        QWak7Bb3SAIBIG/cd8MiXdSbZ3DNR/YFooE9Xrpj62BL+pN9k5ZKVBDHww/s76WuFiTmL7okNFMt9
        xTVmkUSECNH7TaepbkIjhDHAVGRxVeuVm7lyQhZr6BIfkBVAj50THDYTbzUfNk4y/9x/cCMG4z6yy
        jzvMSu3iKISceyfIRjRxku7n8aXANOfyIkDa7rVQdm+ekiN4hKhiHP/HyPXosWFIeN8Y5qCAdfLhW
        wBqMw6M+/EV42OczhR+qzNt9K7ppT1aLFNiYlK9PRtledBh/q4TtFnFlc30m2Doky0uzP/mz12QOi
        GgZNWeeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEwS1-0035yB-23; Mon, 09 Jan 2023 18:00:49 +0000
Date:   Mon, 9 Jan 2023 10:00:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Meng Tang <tangmeng@uniontech.com>, keescook@chromium.org,
        yzaikin@google.com, ebiederm@xmission.com, willy@infradead.org,
        kbuild-all@lists.01.org, nixiaoming@huawei.com,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        sujiaxun@uniontech.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] fs/proc: optimize register ctl_tables
Message-ID: <Y7xWUQQIJYLMk5fO@bombadil.infradead.org>
References: <20220304112341.19528-1-tangmeng@uniontech.com>
 <202203081905.IbWENTfU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203081905.IbWENTfU-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 07:22:51PM +0800, kernel test robot wrote:
> Hi Meng,
> 
> Thank you for the patch! Perhaps something to improve:

Meng, can you re-send with a fix? We're early in the merge window to
help test stuff now.

  Luis
