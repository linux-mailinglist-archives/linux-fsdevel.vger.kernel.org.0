Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDC41A6A33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgDMQsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:48:45 -0400
Received: from sonic308-36.consmr.mail.ne1.yahoo.com ([66.163.187.59]:46137
        "EHLO sonic308-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731784AbgDMQsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1586796520; bh=bElmMGeGrTv4UdyeT/oxmt1v3extMJthOFW7mXr0BPk=; h=Date:From:To:Cc:Subject:References:From:Subject; b=G6N26eb/yIVXiQw0qE6W8f1AUrYzP2Vnj639Wh1dRrPcss2DmnvhpM6jv3pahSdqrFPJylW7ww6buFHDad/XWvsA0ORW2x4Pqk2m7Rl3wB//SK75W/34y8J46ioDHOwyfgZuoNAirliNbZMXd2ssFqHczVm6uwjizaz8w4+roui8RAImkHC1G8HM0eLi+lIN+UpXYFFzsHxk0/fpUN7p1G+a08pwx9Q5aXfZHZH6JmyFThQVGq3uLKmzFlPLEIMb4NFQpKquxYjJdjfNPnsB8XJgTLhVI0idEPo/POaX9oGrUXioupjEW8jrcagzTy6jliHX7oUMzGd4K7n/idELdQ==
X-YMail-OSG: LNqYr_cVM1k37p0BEArws0j2SMpuYOmfY_EMhqarqChYwpxuxB8KFGB5vV9fJsz
 iIhnJb3jaXvCGfE2aSt4doan7aJ6dnzbyn89vnjq_SV8cDsINa2Fqtq5gc4ss64xsowGwGkY0CFL
 bkDlKb.TBuK5i6h5kMoSuaco4ej32E_P1gf2QALa7eJ4GjX3kPp1EPZiOY7t91D7aYL8_D_qdt3H
 vO3CrC3b3OzsJM2iIxCQTrZhgw_xhCgXknUXKldyXSCljK.xwsr6ptXFP0ShFiClnDhnnzQSeb8U
 8moIDJ0FYYVSUa5fkj9bVqabZrzyVLc1F11Q19S1nCLBWPK3XhvJyJYWLAXyfcB.b.GvP2KFnYxd
 .622OG1af5W_BeM9zU.B0c_zanoiWMHY5iDCE4YL7hr0Z9_vvXrbkIdlZzinFy1cDN.jqFa6Audw
 gINBZnjZwlUDG_kWvj7oLaD6DBTOlN5FSKkY3TqJCvii_60QSyGPbhVDbzMpyoK9WrDLrc9Qdcxv
 vplOG2bPeK6hS1GT4th80ccQjURFsuAX4URg1Ud7Pg.Rgy5_m3ChN8gh_gPG6s6yro2abNq1zTVk
 5MiCxH5yW6Um1DLHst.PQPVBq0jsOJJINwuE52hU5csMNA1iS878f2XIdgfuJ80uGTw9C0Suq7MV
 jUQPvf7Jn.r0CPz6wIduG5MdgGa5MUc6EaQ9Uk2BgNfahC6Cjhlm1NdcNMBrpoQKcFCw2MeCoqOX
 XtKpIYf0Cwkg3P_imu2PoQSeZEBtLzT7fk1O2mdzN7Add.8_6nITJWcVQ9tLbKVk5cO0HzcmEX7G
 Wk3y05Z.DkCwSpSMcv1Pt2tu2Jm5sCTeBqMvJeRrc0sWL2q8Z_Hv.ZmxNrFPZ7yIhNm3tp7M33Oi
 YUy0yCJ2V8JL71R14dSZ9slsRCO26FHABrYpmPfindFDov.JMXs7_zdnKFTDtVehI.Pf1xUAh8WP
 eGk0o2xRK12vs3jQejL8E3_HS7MSqPRXf9.2YkjO9Mbn3MXzicXwMk00MgoB8EV_tGnMZCtZIwYw
 foZddko11qm3tQQONrDFvdKb9qax0V2OWdPkraYbNgpukrtllXThKRQhV2u34MzH3hmr3_urqUQs
 ClkLC64opRM.mNzxEj.VxatPE83c0L5SREGkqlyOHuHTA9bofUTDAb02wx7mVSNIOH8CIyvO8GS_
 71HVoS2qnZAM_.wmbp1Lyyow_1hO6MGdI42Gg8O2AH5E5faSJVUDvjfsVcv2SiaiCKIOZvlOKCxX
 v9jYAeL6UkGR0Yy3ugJ6EPuNc1WvWQi9gkbZ6aNb7RshbfeE_dscpY1d691.OuEZa2dVD.of3eIn
 DqS2tCYzshoHXS.Hq5wHrwSAUsFwh12D8q0VPrMoQ3E0aTchM7X7hCVNafw95qXWfliTAppfKhiM
 EUiz_SVqm8in1o_lrVJUImDS0i2fBFlWRye6G2WZC.oU45UJJqcfnqc5_0WiZN8Ktf.JESTnVovd
 BytjHtcq9zOOXZcUjJ_3yQ73uipcIyH3TcxKvspLA2cqw95M.gQwTZc76yQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Apr 2020 16:48:40 +0000
Received: by smtp424.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 700b38ef91bca85d70b21427f6befc3c;
          Mon, 13 Apr 2020 16:46:38 +0000 (UTC)
Date:   Tue, 14 Apr 2020 00:46:08 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Lasse Collin <lasse.collin@tukaani.org>
Subject: [ANNOUNCE] erofs-utils: release 1.1
Message-ID: <20200413164544.GA5578@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20200413164544.GA5578.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.15620 hermes_aol Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

A new version erofs-utils 1.1 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.1

It's actually a maintenance release including the following updates:
  - (mkfs.erofs) add a manual for mkfs.erofs;
  - (mkfs.erofs) add superblock checksum support;
  - (mkfs.erofs) add filesystem UUID support;
  - (mkfs.erofs) add exclude files support;
  - (mkfs.erofs) fix compiling issues under some specific conditions,
                 mainly reported by various buildbots;
  - (mkfs.erofs) minor code cleanups;

EROFS LZMA support is still ongoing, and the previous preliminary
progress is available at
 https://lore.kernel.org/r/20200229045017.12424-1-hsiangkao@aol.com
and
 https://lore.kernel.org/r/20200306020252.9041-1-hsiangkao@aol.com
some minor updates I'd like to send out with the next WIP version.

In addition, as discussed with Lasse before, XZ Utils liblzma would
probably support fixed-sized output compression officially later
as well. But it may need some more time then.

Recently I have little time for features due to struggling with my
upcoming English test which has been greatly impacted (delayed) by
corona. While I'm still keeping up with community by email and
available for all potential issues and/or responses if any.

Thanks,
Gao Xiang

