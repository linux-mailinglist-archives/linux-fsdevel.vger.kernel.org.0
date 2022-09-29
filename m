Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA45EF014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiI2INA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiI2IM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:12:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A0119193;
        Thu, 29 Sep 2022 01:12:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E479C68BFE; Thu, 29 Sep 2022 10:12:53 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:12:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 03/29] fs: rename current get acl method
Message-ID: <20220929081253.GA3699@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-4-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-4-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just wading throught the rest of the series - I think we should
also rename the get_acl() function to get_inode_acl() to match this.
