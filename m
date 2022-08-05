Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD32758AEC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 19:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbiHERSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 13:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiHERST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:18:19 -0400
X-Greylist: delayed 2042 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 10:18:00 PDT
Received: from blackstone.apzort.in (unknown [202.142.85.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134DF2C640
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Aug 2022 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=anurav.com;
        s=default; h=Content-Type:MIME-Version:Message-ID:Reply-To:From:Date:Subject:
        To:Sender:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pOLDYF7e8SPsYexiq3BwIVlm797A+sut/rpNkFKnmZI=; b=SgjMeXTeD1RxdLaVXa5CsvbE/v
        5V0KRiahrb+iLnTxWsR8xB4CGOXXe5Tx2q3OjnYgDbBJRH3Wcbb8xfFHDa3WYfaQGyAwSkQLcv6jN
        3sLoB5jgXEs7SZC2tMW8TyMKq8DBOmD5mq+QrOCW5F9HafeJnt7QLoB/6oCiEdmB7ffL8wRuBfG3L
        i6FzGakklOGc5op60r1TaJuL+0cUWfoeNK5ZHOSSaRbrHLrjnyEfcM1qPt0eRnXPUn+f1GS8m5wZj
        +KBSSOlVRSgxCqy5O2DurErZ3geDx9OPUAEt3FFZ5WCdCGn5Ax2TT/3lVXDLZXMqmghMaZN0ohs6B
        WAJAY3DA==;
Received: from apzort by blackstone.apzort.in with local (Exim 4.94.2)
        (envelope-from <apzort@blackstone.apzort.in>)
        id 1oK0QD-001Rni-RU
        for linux-fsdevel@vger.kernel.org; Fri, 05 Aug 2022 22:13:37 +0530
To:     linux-fsdevel@vger.kernel.org
Subject: =?us-ascii?Q?Anurav_Dhwaj__"THE_WORLD_FINANCIAL_CRISIS_CAN_M?=  =?us-ascii?Q?AKE_YOU_A_MILLIONAIRE!"?=
X-PHP-Script: www.anurav.com/index.php for 191.101.31.49
X-PHP-Originating-Script: 1000:PHPMailer.php
Date:   Fri, 5 Aug 2022 16:43:37 +0000
From:   Anurav Dhwaj <mail@anurav.com>
Reply-To: mail@anurav.com
Message-ID: <ywcmwDLFbP5ppkpBU2SoBPVtDFnoQbTR4WGodCzM9U@www.anurav.com>
X-Mailer: PHPMailer 6.6.0 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - blackstone.apzort.in
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1000 989] / [47 12]
X-AntiAbuse: Sender Address Domain - blackstone.apzort.in
X-Get-Message-Sender-Via: blackstone.apzort.in: authenticated_id: apzort/from_h
X-Authenticated-Sender: blackstone.apzort.in: mail@anurav.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PHP_SCRIPT,
        RCVD_IN_PBL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [202.142.85.54 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.3 PHP_SCRIPT Sent by PHP script
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Message Body:
THE WORLD FINANCIAL CRISIS CAN MAKE YOU VERY RICH! https://telegra.ph/Cryptocurrency-makes-people-millionaires-at-15-people-per-hour---Page-542684-08-02

-- 
This e-mail was sent from a contact form on Anurav Dhwaj  (https://www.anurav.com)

