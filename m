Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4F353BB80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiFBPVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 11:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiFBPVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:21:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5112A5515;
        Thu,  2 Jun 2022 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JIw8aKjJnDAUMfW/ZoAS3ykhzT+7C9tK1kg2A9Q7aFE=; b=dYtKQhtFUXzYAr4tHRCc7eIobY
        OqE7Yfif70F45glOPSt41CFw8FgQ2zhaeZ3A/xgayBzLDgf+ROvjy8kRRwlJaAYsMz/YEwBiWD/sB
        ZrLliJldX1+hlCnicbZof+iHBL23JEPGsqhvZhH5j4CUn5DYwW1ul0zhElxLUFKBwFL6NBGvCAmZF
        4CBDk8rDX9m4nRfBovQRJQN8n18btfznjKeXOG8KfT0WtgyAqS75TbN/w1hhD4EdZtpBz3pzvSIkZ
        AoSEugHfWhTAQKEYwcckFIspB8DdPsM8Ku00B6z52MznXh+xLsicwOMlmM26FQZcLmxAgCjaiozEF
        P0lBVFRA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwmdU-003gSj-6r; Thu, 02 Jun 2022 15:21:20 +0000
Date:   Thu, 2 Jun 2022 08:21:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>, pankydev8@gmail.com,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Tso <tytso@mit.edu>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        a.manzanares@samsung.com, Tyler Hicks <code@tyhicks.com>,
        Leah Rumancik <lrumancik@google.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Zorro Lang <zlang@redhat.com>, shirley.ma@oracle.com,
        chandan.babu@oracle.com, konrad.wilk@oracle.com, mcgrof@kernel.org
Subject: [ANN] Discord server for testing Linux with kdevops
Message-ID: <YpjVcHuxhEQwPusN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've setup a discord server for general discussions around Linux
kernel testing with kdevops. This should help with coordination
around kdevops in an accessible way for:

  * The shared kdevops repository and dependent trees on the linux-kdevops
    organization: https://github.com/linux-kdevops/
  * Sharing of expunges for fstests / blktests for different
    filesystems / configuration / kernel releases
  * Shared hardware resources such as the public Super Micro bigtwin server
    currently used to help test fstests and blktests
  * Future potential shared cloud credits
  * Streamlining reports for new issues found on stable kernels or
    Linus's tree or linux-next
  * Storing / sharing test failure artifacts

The discord server:

https://discord.gg/pWgZZhRp

  Luis
