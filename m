Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6C162343
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 10:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgBRJTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 04:19:44 -0500
Received: from sonic303-1.consmr.mail.bf2.yahoo.com ([74.6.131.40]:44536 "EHLO
        sonic303-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726281AbgBRJTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582017583; bh=zI0m+DRhZDm01EKX+YHsQU600DuE8AwybL7Vu4lblwE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=WCeUcvxPv7HA7K1ovvf3JlKld3493p6qqc3TRHYkfViq6YHVnLYJW5ALCf0ecpNw+QsvHCWsTgwBBt1ZkopGxcauB8n3EApOi8Cuc+zY0aCIqoc7P+KsjvnHPkdGCtcjzfyg+LgQUj1Z0y2yZsaCBi3fNptjfek/IJrZRlp6zFI2jKYXL6F3LMRxSs6yiz9VS6yMXts2CjBt1dJyiWVifCwYyQYYnxiz9f373BNHTBO+JyJCKR2NkMK2B+24VZ2WJVRM8oMSUSOj3pz4lozwyorcnmuGc0sg/ecbdKHG3AiAXXCXDL1Xp5gPSg2FysrPHM8/w1LRpMvlkB0jy2ZQbg==
X-YMail-OSG: x_HpDTcVM1nP8xZQGvn8ikNc0e_O4z3sshuUuSfvSQEVaaEy172EheL18kLRl1o
 ZB_xUnvIVM9J9NswspUzZU5JojO1TqQizGFS35HJZCdk7Rko_kWAeSDDao.TIvGcttu1SLAzacKX
 5b0AQSVZIFrDN5Tt7Se2IbU0o0IJtl5HagMc92ScIJl84f0qFlhNtyuELYyo9Y_IWjTXhTfRnir4
 Y7p6kFUyRWlJ1EkTw49GO_EIwIyeeKNAO0scWRP28OuBZ4PrD_YFL6GurFCRL20j6JbQGwVW1_9L
 SCBLx8qE4ZjaM5Mu7V26T_HTbX7aZhybIAyIgabTvtJ.E7EnnaZL829_Duwg6Fo.0A5vKLQZXTfT
 SZ6JFmhT6YvNspT0BCyAdTIUBgc8l4EKUlu5_NlAmvmJVNPALQ7lBFaU5dUWkU3eCUPEShGFivGV
 1tRyd7fS4MCQGt6WdWbAvUZxg.ppWv5wWBEdu2VEAaiHKL7_cTgn6DFnEOqTlM4pPASwM5si1TDQ
 A9d2MpMKbhG2GRGiWxuImJ_Lvsytns6ZaaaCoEiFM8kSPPuu8Cngg6uigmmvXcxr7i5S_fbQS_YT
 PwzbNbx1iT.W.Ulvzo.vX5GgunmLkvD6pSRndqnxBEA_XGmHLxRwst00TvmcCaC.Uio.OZDDY7f2
 7o7woF0o1cOW8vepHp2PCuxC.vpjvNwu2kz.aKah1oFSbk_w.NgMrooZ3Fg1D94cc1MD7SvtYdoZ
 QoI8z1QyIgbenZdEO9fOPeL.P.sGechbWXfOhOx7EK_t_pxJTpelqUplm30nM5u.2oT24bsMXcA3
 GCJWgKxcZ6GIR.5yDQBM04A1U_VBt_ruov9ZLOzefSP7qeCEnE5wVIEOQRaub8UsOkrZxHc4MLJl
 jvWR.Rqt_C20z_lebl8RED..KU09b9.m7I3xTRczta6SNdCdkLq1O98UQVIlPzlaHKCrkXt666oy
 vUEQSGQx3FzSyImRyMT0Y7My0KOCCtzu0vpkqD_6QWh2.QeyEPQsqIkkqJsGP3VitB87H4zDkhQ1
 4JGqw_V3HT9UWHryWpN_aXc1dZL7Kw75uxDS2aUQKJakRKlJgxUwu8SQX6XfkhbS1PgsBVMnISt8
 _ZL0cH2maT0njvR9Lh6TLw7IF_HZTTXC9HZE2TrgoaO3jx4SIT7i3TBA.A72Dmf_eYKb17_GFrmS
 AAIPlkKqesIcwa.lq6RADG5XDE63iOfutGc08ZCBoJEcuS6j3oVJXPqArhSKIi.7Eu0YPYEDUM16
 xcF2UJOH1qYxIcvJjDM_w_hOOu7RJfmAtZHnVmMN2a1bYjX2744NzbhJWEBhG.EBUMG4FyKH3l.E
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Feb 2020 09:19:43 +0000
Date:   Tue, 18 Feb 2020 09:19:38 +0000 (UTC)
From:   Lisa Williams <lw3628517@gmail.com>
Reply-To: lisawilam@yahoo.com
Message-ID: <421324845.3198794.1582017578698@mail.yahoo.com>
Subject: Hi Dear
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <421324845.3198794.1582017578698.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hi Dear,

 How are you doing hope you are fine and OK?

I was just going through the Internet search when I found your email address, I want to make a new and special friend, so I decided to contact you to see how we can make it work out if we can. Please I wish you will have the desire with me so that we can get to know each other better and see what happens in future.

My name is Lisa Williams, I am an American, but presently I live in the UK, I will be glad to see your reply for us to know each other better to exchange pictures and details about us.

Yours
Lisa
