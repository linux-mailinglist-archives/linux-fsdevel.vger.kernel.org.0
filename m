Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E716B3067
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 23:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCIWUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 17:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCIWUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:20:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CCEF8F20;
        Thu,  9 Mar 2023 14:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jK36Zpm8T2on+df54b6OGLN8ramQR+T+L8HPs8R5yHE=; b=MQBnApNDuji9teSFgOuyjM3C/p
        Lgjgf584li4FUT3/bLPnV5yqTuo2UTXDrn/714v2Ip8g3XpbRRwZD7nJgpfEz6h2qyYzLRoVFAzS5
        tMd/9xsj+xvHf9pg1aj6/tfQOstrhGZ+G1zt8z2KHggdwT/JzAOm9MQzVoQv6izhooEbpCzv0yw5r
        tM+8qfELGYvw7DcEBgzyGxOP+nBEwfiCipPOReirB45OyXkLojYq6dLPJAZ2LdHzds1OUB+inU0LV
        2hzU4mCm7TVY5QLhVwYJxgZVITHlU54t7YIlOR63U6xiYpBenGFdRnv1EDD5XMZzQjyOtadrDKozg
        W7Wm31lw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paOao-00C8rx-Vc; Thu, 09 Mar 2023 22:18:34 +0000
Date:   Thu, 9 Mar 2023 14:18:34 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, minyard@acm.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, song@kernel.org, robinmholt@gmail.com,
        steve.wahl@hpe.com, mike.travis@hpe.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, jgross@suse.com,
        sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
        xen-devel@lists.xenproject.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] sysctl: slowly deprecate register_sysctl_table()
Message-ID: <ZApbOilWsw9Sk/k4@bombadil.infradead.org>
References: <20230302204612.782387-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302204612.782387-1-mcgrof@kernel.org>
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

On Thu, Mar 02, 2023 at 12:46:05PM -0800, Luis Chamberlain wrote:
> I'm happy to take these via sysctl-next [0] but since
> I don' think register_sysctl_table() will be nuked on v6.4 I think
> it's fine for each of these to go into each respective tree. I can
> pick up last stragglers on sysctl-next. If you want me to take this
> via sysctl-next too, just let me know and I'm happy to do that. Either
> way works.

As I noted I've dropped the following already-picked-up patches from
my queue:

ipmi: simplify sysctl registration
sgi-xp: simplify sysctl registration
tty: simplify sysctl registration

I've taken the rest now through sysctl-next:

scsi: simplify sysctl registration with register_sysctl()
hv: simplify sysctl registration
md: simplify sysctl registration
xen: simplify sysctl registration for balloon

If a maintainer would prefer to take one on through their
tree fine by me too, just let me know and I'll drop the patch.

  Luis
