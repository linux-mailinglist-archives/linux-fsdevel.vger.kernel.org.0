Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2981E48E4D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiANHVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 02:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiANHVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:21:03 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA74C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jan 2022 23:21:03 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id o1so15497331uap.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jan 2022 23:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=S5sdFu0RQlZFvupo/qwNdlJ2GO8zZANN1PS6veJLDy8=;
        b=C4KfeYGSlOeVPw+woYhLpPYBPd2SO43rD95FBt4pt0Tqq/WUIcXacNn0SMIDqUTDE4
         Lk4Clndrjg2BltdKBGNFBXdHxWwt364NESRYpbDfcPcS/Cot6l2TTOzEJzY3Hai2oyFr
         3QQFOlw+opIOV696VRcf0uYHVwsJ6HofAcDt0BelDgwwSV3GPYweFqe92aECM8hTbQn5
         qaEcLgd/uxENStwTw7H1hz6/Jvnadgc3WiMDXiIal+w5ELKg4tmDWJJteg5naSUA+Nz4
         jLq10QDSN9ahI36bD7JdrY9oUNgELTHa5n1KrDEZRZwi/Wl+rZYVfwTS7zLOr8f+CJ7j
         jdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=S5sdFu0RQlZFvupo/qwNdlJ2GO8zZANN1PS6veJLDy8=;
        b=Ck4PPZOVA+1y9FCjCMOzrb4fBdxWS+ivXFH+tp4N8nVdC1n5Cg7bnOGav89P1u/MOy
         CU8dN/ijaIZsUwHZ27zzKve6Zl6YLpO1RIGqV1XdUGjGEdDfcVhDGyl90wHeSdI45aN6
         17VRvUpULcEsbK5CHupyKPEdqldPa/3WkrRVtsKLRBqiTGa8cfc3LwbEEMLhxHiM3P/4
         DQwXE03YO3LGWnbvWCawzyhieWBqnC36dlTQrfe/Kai3s16NluEHR7O2xOatNJjHKfD5
         FkliNcLG51Nzstks22CuoCvbTsaBSvlNmcTyr61iQwBKPcyRDfyMgt/2KGnsHgAvvmgM
         RULQ==
X-Gm-Message-State: AOAM5332ocPcT/+TUDBoDImjnwQDNQ6kd72n4+7KMVfpZG9+HZQTdJVL
        kwKnb15zLuiT439Wq34O+Bvsz6C2sM1RqOOgjZQ=
X-Google-Smtp-Source: ABdhPJybhnBsDzq688bt3KBxWWzSJ6p7RXMkHsmjVPweWS9wIKca/XQyvhJdT8nlsL7JN80CqXu9PtwME+dYKnfSSiw=
X-Received: by 2002:a05:6102:370f:: with SMTP id s15mr3775696vst.3.1642144861947;
 Thu, 13 Jan 2022 23:21:01 -0800 (PST)
MIME-Version: 1.0
Reply-To: kl621816@gmail.com
Sender: la621816@gmail.com
Received: by 2002:a05:6102:213a:0:0:0:0 with HTTP; Thu, 13 Jan 2022 23:21:01
 -0800 (PST)
From:   "Mr Ali Musa." <hippolytepilabre@gmail.com>
Date:   Thu, 13 Jan 2022 19:21:01 -1200
X-Google-Sender-Auth: RULBV13dc5tqWBcPAgOHh3MM2rI
Message-ID: <CAEfXncDH422aurz4a6f59kv4y1cRW8ZdYKa1kwuUitvOVOnT3w@mail.gmail.com>
Subject: INTRODUCTION:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Friend,

 How are you today, Please accept my sincere apologies if my email
does not meet your business or personal ethics, I really like to have
a good relationship with you, and I have a special reason why I
decided to contact you because of the urgency of my situation here.I
came across your e-mail contact prior to a private search while in
need of your assistance.

INTRODUCTION: Am Mr Ali Musa a Banker and in one way or the other was
hoping you will cooperate with me as a partner in a project of
transferring an abandoned fund of a late customer of the bank worth of

$18,000,000 (Eighteen Million Dollars US).

This will be disbursed or shared between the both of us in these
percentages, 55% for me and 45% for you. Contact me immediately if
that is alright with you so that we can enter in agreement before we
start

processing for the transfer of the funds. If you are satisfied with
this proposal, please provide the below details for the Mutual
Confidentiality Agreement:

1. Full Name and Address

2. Occupation and Country of Origin

3. Telephone Number

4. A scan copy of your identification

I wait for your response so that we can commence on this transaction
as soon as possible.

Regards,
Mr Ali Musa.
