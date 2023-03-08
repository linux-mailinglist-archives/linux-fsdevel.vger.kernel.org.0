Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180316B0C4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjCHPP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjCHPP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:15:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E41BF8C5;
        Wed,  8 Mar 2023 07:15:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51F93B81D2D;
        Wed,  8 Mar 2023 15:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFECC433EF;
        Wed,  8 Mar 2023 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678288522;
        bh=ckd6OHb0gCWxoJ1b0/6DTQnfwh7ZbRtYCcoN1hkwPFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eps92E5WeSIYwzl3lAooYKZn2q/BWO70KJ8coauiCYMBKmog4C0NduZBr1cwE6jAp
         IaJn42e4SSkK/+V/kKtnH+wKytZtSop3COU947FYdO9IoVVZbRqa83mzXM2++DKMK5
         NPIwmH+0FByP0/PbC8W1VfJlNU5KbiGe+tQjdvThVViSgYmBwaHby5DQjkjTjOLzxO
         TMJ9lYs7r5po0PiJC03kDDg8Q/CvzWFNnn3CC2Q4DiqZHgmko0MZ8KdGlKryK/ce2e
         yJorLx6Gu6+RGP+3CLK/5VVdkSXtiR9xYKNHvy4m5PBdPkbQcaGFivEbFfXoktQSpe
         p6/6enWnpD9KQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: repair a malformed T: entry in IDMAPPED MOUNTS
Date:   Wed,  8 Mar 2023 16:15:15 +0100
Message-Id: <167828841056.737958.2008329140627023278.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308143640.9811-1-lukas.bulwahn@gmail.com>
References: <20230308143640.9811-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=455; i=brauner@kernel.org; h=from:subject:message-id; bh=ZcMI88vp30j3Pb/JVfQ6Kpswmo6FuSeIphkXIPFRCgM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRwLCv9JLtNJf7eZGHLwMVZBru9ixhZNlxY/PrF6i55pVkL Xokad5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE5zAjw++yuae+zprMzWTdYnVo5j GnfeZ/N65qLpSqFq3fJundUcTI8I2z48PX8OVvrsw5xKHQz28cv+bM4/tRgfOspbYek+1dzAQA
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


On Wed, 08 Mar 2023 15:36:40 +0100, Lukas Bulwahn wrote:
> The T: entries shall be composed of a SCM tree type (git, hg, quilt, stgit
> or topgit) and location.
> 
> Add the SCM tree type to the T: entry and reorder the file entries in
> alphabetical order.
> 
> 
> [...]

Thanks for spotting and fixing this. Applied,

[1/1] MAINTAINERS: repair a malformed T: entry in IDMAPPED MOUNTS
      commit: 5b8e5319affc977d24b8ce7edd295907e969e217
