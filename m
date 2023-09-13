Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3049E79E147
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbjIMH6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 03:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbjIMH63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:58:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2C2173E;
        Wed, 13 Sep 2023 00:58:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1827C433C8;
        Wed, 13 Sep 2023 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694591905;
        bh=iIe/EVJUjeXRzwCh0/Mp/4IVeq58KNtEj6KHNildhCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEPppJF4o7yTDveQ3wwMBbd+meHaSYMxJGUNhBGss2DTdWJyJsqGFJPiuzlM0P2rp
         2v/qwfrz2AHcjGmMOOoaNNnNlGtLT6axII4vsx/deE7m+OPCa7lrnLjKCxp4HYmc9z
         rHg0eAW6bCF+chcYg/KfSO3kVPoRiWovgkVahJbKfCc7+A7+DespEcIunQXYHdDzsW
         eaG2VypMrf7j1DhJP4r+/whCYrOiDqzy9JYEIJKMMLsuU6J5yLF1auS9bkteutRlsj
         cMQPicHZUsrCvDdWdPTnTOmajRgNJGTswAfsbL96lRquAMfpqsX7cgiQviftDJ6ssP
         ctUJC/KivwlFw==
Date:   Wed, 13 Sep 2023 09:58:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Teng Wang <wangteng13@nudt.edu.cn>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, edumazet@google.com,
        netdev@vger.kernel.org
Subject: Re: Bug: rcu detected stall in rtc_dev_ioctl
Message-ID: <20230913-oberwasser-zustrom-e17237b2e154@brauner>
References: <5b52187e.3b86.18a8d4953cf.Coremail.wangteng13@nudt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b52187e.3b86.18a8d4953cf.Coremail.wangteng13@nudt.edu.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 02:45:07PM +0800, Teng Wang wrote:
> Dear All,This bug was found in linux Kernel v5.14

Familiarize youself with how to report bugs according to our
documentation. This isn't even minimal effort here.

I'll try this nicely once. Continued dumps of similar low-quality bug
reports will elicit a much stronger response.
