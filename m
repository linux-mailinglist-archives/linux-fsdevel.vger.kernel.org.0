Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9F4B997C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 07:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiBQGym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 01:54:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiBQGyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:54:40 -0500
Received: from out20-109.mail.aliyun.com (out20-109.mail.aliyun.com [115.124.20.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FA27F295;
        Wed, 16 Feb 2022 22:54:25 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04747014|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00194993-0.00333106-0.994719;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.MrHN41i_1645080860;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.MrHN41i_1645080860)
          by smtp.aliyun-inc.com(33.18.97.150);
          Thu, 17 Feb 2022 14:54:21 +0800
Date:   Thu, 17 Feb 2022 14:54:23 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: [PATCH] fs: allow cross-vfsmount reflink/dedupe
Cc:     "Josef Bacik" <josef@toxicpanda.com>, viro@ZenIV.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
In-Reply-To: <164507395131.10228.17031212675231968127@noble.neil.brown.name>
References: <20220217125253.0F07.409509F4@e16-tech.com> <164507395131.10228.17031212675231968127@noble.neil.brown.name>
Message-Id: <20220217145422.C7EC.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> On Thu, 17 Feb 2022, Wang Yugui wrote:
> > Hi,
> > Cc: NeilBrown
> > 
> > btrfs cross-vfsmount reflink works well now with these 2 patches.
> > 
> > [PATCH] fs: allow cross-vfsmount reflink/dedupe
> > [PATCH] btrfs: remove the cross file system checks from remap
> > 
> > But nfs over btrfs still fail to do cross-vfsmount reflink.
> > need some patch for nfs too?
> 
> NFS doesn't support reflinks at all, does it?

NFS support reflinks now.

# df -h /ssd
Filesystem              Type  Size  Used Avail Use% Mounted on
T640:/ssd               nfs4   17T  5.5T   12T  34% /ssd
# /bin/cp --reflink=always /ssd/1.txt /ssd/2.txt
# uname -a
Linux T7610 5.15.24-3.el7.x86_64 #1 SMP Thu Feb 17 12:13:25 CST 2022 x86_64 x86_64 x86_64 GNU/Linux


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/02/17

