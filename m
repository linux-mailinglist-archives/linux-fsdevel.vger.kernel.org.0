Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D6640303
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiLBJPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 04:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiLBJPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:15:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06569BA603;
        Fri,  2 Dec 2022 01:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CBF6B82110;
        Fri,  2 Dec 2022 09:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA3AC433C1;
        Fri,  2 Dec 2022 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669972502;
        bh=WRUi9B1zBMc1Pfwd95w3vNVsVHfvZF4H69ojwztT1D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnpZSBVDXDjkqfd/mm1g3x82Hmho6lZP27/lbYBYzEY/vK21O7mDuUNiMEN3sT0gW
         uf4CkZffM0yyNJiy3hhyRhnaDkzb0OLSRq8CALdUIY4dhQFHDdH3f/vJLA0RznwHlH
         yfrbP18VRmgso35C3DiOL0EwOqTKnlgmGsQYW2tXd75/wGaNwdKtKKt5ppFi0tFxNv
         2DIhdaykainF93y/rEVOXAvbGpR60nWinCIYdmehkE3SvqYdzwHk0ffGqHHlCI5ncU
         SwFag4FznSZ5nF3smN4RQ9cEj49ZD+zHLOKbxlMORfICVYH2EhIMUtgsykGDQxamgw
         jzbUtFcGOYM9Q==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uros Bizjak <ubizjak@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH] posix_acl: Fix the type of sentinel in get_acl
Date:   Fri,  2 Dec 2022 10:14:49 +0100
Message-Id: <166997239439.3554733.16647145105300748675.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201160103.76012-1-ubizjak@gmail.com>
References: <20221201160103.76012-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=268; i=brauner@kernel.org; h=from:subject:message-id; bh=YiKpUexH02xRtz1GXfd/B5OwPTHyQo7+MK5cilC6/bU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR3HmIyOpYtEW0YemnrJX12Xa55f5YXnPis/uOs55TWGxsn 1Nuf6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI01FGhh0tvwu3T7384Yntx65TF7 X2G67/5qHEfE+g4pTxCg4Z5mCGf5rqryZ+ZOeZ6OKvLqnd/Keafy1HBPfVF88+yl5e5JQfyQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>

On Thu, 1 Dec 2022 17:01:03 +0100, Uros Bizjak wrote:
> The type should be struct posix_acl * instead of void *.
> 
> 

Applied, thanks!

[1/1] posix_acl: Fix the type of sentinel in get_acl
      commit: d6fdf29f7b99814d3673f2d9f4649262807cb836

Christian
