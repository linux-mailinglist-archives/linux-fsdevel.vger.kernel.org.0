Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60279607E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJUSy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJUSyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:54:54 -0400
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 11:54:48 PDT
Received: from web-relay3.stackmail.com (web-relay3.stackmail.com [45.8.227.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB24D4E1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Oct 2022 11:54:47 -0700 (PDT)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=web-relay3.stackmail.com; s=s1;
         b=JmKwK9EaN/H4BQt7ZeVTxwyn9oQ5g8d/UhbQMiR3V8JsLnJLSry4w/1dBmClbDLB42HYJalrss
          9jAyLHqKTglJmP/h+740BPE+s+ehE2x4E41BSGS5us3xbm0Iw9BpizbU3LTihn46m4qTbW9Ovf
          /68gGihhICSVqZtBtYyEceL63Uv8RNJanhjwkMQQXiMWyjgVntOv4Lf7bnEb7mhzQS4jCYxnR6
          nXVWqK4xIsLnkeSl0hKSYNKn5YQetryReCKXP21ntb678FrJ/rhLCfmSiZ9vMKoybIwAdn+rqN
          X7XlgMod89ucYV44lEY3eQJF1wpIaYWLQCizOlbYbWkX/A==;
ARC-Authentication-Results: i=1; web-relay3.stackmail.com;
        iprev=fail smtp.remote-ip=10.3.6.23
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=web-relay3.stackmail.com; s=s1;
        bh=0aHii8aN23vEF7u5f5uQm1z593eqZqExjt9XjgjkhUg=;
        h=Sender:Date:Message-ID:Reply-To:From:Subject:To;
        b=bbGaJr4ya9u+qn0ejCgR23cuFJfeyPPv1Mq6OzKTNwOSmPbFupEmvGjRlt3IrsSndzB6gNTUTf
          +1kwlh+rC2ohYjizpnC/v6G/+YtSqgj4LQsNU+j+AcL4Arr2FrpisOa6ddZK4VhB+Sj48UhjQr
          KlMn++yY0vqP/sBA+jaQQqOQ7HNYH2EVqzz/1LlOW2TRVmpgT7+7X9+gwFFgfvE3dzRPawXxQh
          3FS4mHcIfWdjUu3d57JhJdefIoIOnGnAnz6H7Vghl9k0Wi3JK7badkLP8LxsSH+Zh00ZkDSENB
          QotmwCzSKssQHlg7xD7vHzLQzU0DJcLazZpiJ8BBuHqFVw==;
Authentication-Results: web-relay3.stackmail.com;
        iprev=fail smtp.remote-ip=10.3.6.23
Received: from [10.3.6.23] (helo=web58.lhr.stackcp.net)
        by web-relay3.stackmail.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <noreply@aolfmarrakech2022.com>)
        id 1olx8l-0000HK-01
        for linux-fsdevel@vger.kernel.org;
        Fri, 21 Oct 2022 19:53:07 +0100
Received: from 7af05f09d0 by web58.lhr.stackcp.net with local (Exim 4.96)
        (envelope-from <noreply@aolfmarrakech2022.com>)
        id 1olx8k-0007gB-30
        for linux-fsdevel@vger.kernel.org;
        Fri, 21 Oct 2022 19:53:06 +0100
To:     linux-fsdevel@vger.kernel.org
Subject: smacot
X-PHP-Originating-Script: 1262826:register.php
From:   samih.hicham@gmail.com
Reply-To: samih.hicham@gmail.com
Message-Id: <E1olx8k-0007gB-30@web58.lhr.stackcp.net>
Date:   Fri, 21 Oct 2022 19:53:06 +0100
Sender: noreply@aolfmarrakech2022.com
X-Authenticated-Sender: 7af05f09d0
X-Originating-IP: 
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,PHP_ORIG_SCRIPT,
        SPF_HELO_NONE,SPF_PASS,T_PDS_TINYSUBJ_URISHRT,T_SHORT_SHORTNER,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: okj.page.link]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5283]
        *  0.0 DKIM_ADSP_CUSTOM_MED No valid author signature, adsp_override
        *      is CUSTOM_MED
        *  1.0 FORGED_GMAIL_RCVD 'From' gmail.com does not match 'Received'
        *      headers
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [samih.hicham[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_FORGED_FROMDOMAIN 2nd level domains in From and
        *      EnvelopeFrom freemail headers are different
        *  0.0 T_SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  2.0 PHP_ORIG_SCRIPT Sent by bot & other signs
        *  0.0 T_PDS_TINYSUBJ_URISHRT Short subject with URL shortener
        *  0.9 NML_ADSP_CUSTOM_MED ADSP custom_med hit, and not from a mailing
        *       list
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cher(e)  animation_sex
 okj.page.link/ujii#
shirl animation_sex
 okj.page.link/ujii#
shirl
Bienvenue sur le site de la SMACOT.
Nous sommes heureux de vous compter parmi nos membres.
Cordialement.
