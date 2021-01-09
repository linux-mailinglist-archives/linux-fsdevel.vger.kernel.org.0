Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E9F2F03B5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 22:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbhAIVHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 16:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbhAIVHO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:07:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99CF7239D1;
        Sat,  9 Jan 2021 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610226394;
        bh=82DAPj85UpnL8li+cswzW/c+MUVI5rJnOFam+qbBAIg=;
        h=Date:From:To:Cc:Subject:From;
        b=f4hnUcFSHUhvN4EgrzUVwyFmIrOFYnDUvv4NwADYZwyjlgLpfNOiTHFxYKnMc2rXk
         VEwboKkoGg1YcB/tXz4i6hB53G+QIsm5+ddtwibHXrsd9vsJEEZdL7N1ayfEQsIyt4
         9DxkDpHhConrrtSsJbCHq4UOtMclKJwZYo0XaOm8JjfiCgWMecDGXnhmI7+YrXnJav
         66QmiiiHuV4Vmsn+5iplNtshgur4IWJmm5m7iwAXDBZ6bm6n3idu0x/LbCoJ5gGV5L
         W7CKRixdZVE30e4dGV/2h0x8mnv+dRUq5wNzNd9ztTum4TixB2yoncGOWt9jpmqJaH
         IxEp/ttycMEXA==
Date:   Sun, 10 Jan 2021 05:06:07 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        nl6720 <nl6720@gmail.com>, David Michael <fedora.dm0@gmail.com>,
        Yue Hu <zbestahu@gmail.com>,
        Huang Jianan <huangjianan@oppo.com>
Subject: [ANNOUNCE] erofs-utils: release 1.2.1
Message-ID: <20210109210607.GA9532@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

A new version erofs-utils 1.2.1 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.2.1

This is a quick release addressing recent reported issues since v1.2:
 - fix reported build issues due to different corner configurations;
 - (mkfs.erofs, AOSP) fix sub-directory prefix for canned fs_config.

Thanks,
Gao Xiang

