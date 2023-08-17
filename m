Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2577FCA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 19:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353742AbjHQRJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 13:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353914AbjHQRJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:09:55 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1642136;
        Thu, 17 Aug 2023 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=48Maj4Oc5uaXDRN1l09bKvkNpQDUxrj5O8ykLfCCRCY=; b=VGcizsj0cCP8Axz8z08LD6d0yc
        kA0ozrjzZIu0ZjDiIdsAW49b8vHinpJJES8Qzg0O9PcgUYl/kIx9zbIZgxPytsf8HPuO7eJaNvALI
        bS8EUdVEm9J3a7ZHaU0xVu+AMIC3xG4vUCtraFEMul5BO9UKOWVL9AK8dUZEYIUkD7BVFXfHPNffb
        em4Om2otAsiqUseT92Y6aernKTuCH9O/cZqbQqFJFBrRabboB+YV2/WahTTYtWckL+HZ0kArp+ZxP
        Zmrp7et4FPtRJEybLVC0/qh8DDXWDwbfUVO5Bp0UFW/j18PZIPW8FA7fDtViHq/cgWNsAsjS1HEKc
        6tL99ecg==;
Received: from 201-92-22-215.dsl.telesp.net.br ([201.92.22.215] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qWgVG-001zx6-IC; Thu, 17 Aug 2023 19:09:46 +0200
Message-ID: <dd405233-955c-ebac-7495-9a07be5ee652@igalia.com>
Date:   Thu, 17 Aug 2023 14:09:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
 <20230817154127.GB2934386@perftesting>
 <b49d3f4c-4b3d-06f4-7a37-7383af0781d0@igalia.com>
 <20230817165833.GA2935315@perftesting>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230817165833.GA2935315@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/08/2023 13:58, Josef Bacik wrote:
> [...]
> Oh no sorry, just swap pr_info for btrfs_info, and keep the rest the same, so
> 
> 	btrfs_info("virtual fsid (%pU) set for SINGLE_DEV device %s (real fsid %pU)\n",
> 		   disk_super->fsid, path, disk_super->metadata_uuid);
> 
> thanks,
> 
> Josef
> 

Oh OK, thanks! My apologies, I confused the stuff heh
Cheers,


Guilherme
