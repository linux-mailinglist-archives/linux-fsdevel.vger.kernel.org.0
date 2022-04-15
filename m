Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3EB5031C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356404AbiDOXB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 19:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245219AbiDOXBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:01:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C0CFD1D;
        Fri, 15 Apr 2022 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QVpztKrzvaJ0Phl+vGlDJV/C+V3vgG+1jHY+BXaoZsQ=; b=hRRfcbE65oGCATGrJa0r7QWloK
        zZetMAn/NoLnc5DwT0ypGGapxqTz3GdJqcIKiygZh0wGIYeeUb6yEJxDVWrf9jRLulVvfiPwNjSP4
        XKr2+dsHSFSCMJhA0yRrs/M8jNJ+XdUhufWaTNaVwiS6h4YxnfpR0io3sK6MG75qnsrS29vfe62Wn
        d957s2RjcmfHk7e0CwrIZHwDVvRol7XJPekvYdP2Vb63jrAexS3NxmxtkvSTKSo/jqcnQCJCup2ge
        r1wYV2Xw7eMnSbQlPPJT3dzBaxqQKP8JAXFY9oIN8R//JF9CBZ9ou6TWu9XXSGW3EoDSsQKAMqxGP
        Ws15WifA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfUu9-00BdBq-SI; Fri, 15 Apr 2022 22:59:05 +0000
Date:   Fri, 15 Apr 2022 15:59:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     yingelin <yingelin@huawei.com>, ebiederm@xmission.com,
        keescook@chromium.org, yzaikin@google.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zengweilin@huawei.com,
        chenjianguo3@huawei.com, nixiaoming@huawei.com,
        qiuguorui1@huawei.com, young.liuyang@huawei.com
Subject: Re: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls
 into its own file
Message-ID: <Yln4uQCYWw/k0vR3@bombadil.infradead.org>
References: <20220223030318.213093-1-yingelin@huawei.com>
 <YhXwkTCwt3a4Dn9T@MiWiFi-R3L-srv>
 <c60419f8-422b-660d-8254-291182a06cbe@huawei.com>
 <Yhbu6UxoYXFtDyFk@fedora>
 <YhqLnIjopfoBEBcV@bombadil.infradead.org>
 <b07af605-ab74-a313-f8e4-da794dcde111@huawei.com>
 <20220228031801.GB150756@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228031801.GB150756@MiWiFi-R3L-srv>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:18:01AM +0800, Baoquan He wrote:
> That's OK, look forward to seeing the v2.

yingelin, do you plan to post a v2? If splease base it on sysctl-testing [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing

  Luis
