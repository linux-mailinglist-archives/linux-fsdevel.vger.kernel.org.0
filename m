Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0074F6DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 18:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFVQ2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 12:28:53 -0400
Received: from sonic301-3.consmr.mail.bf2.yahoo.com ([74.6.129.42]:44832 "EHLO
        sonic301-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbfFVQ2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561220929; bh=3fXYToOZXvh5MOJ1JSawYDThjnynC/Ekt2gucIg6zZg=; h=Date:From:Reply-To:Subject:From:Subject; b=FwrBLUl7u665XwQeVPTq5hUQ4Ptv5qPcwgE0MfCyAxPjQW66W+sBKlTITy95Xiak8M/9mL3k87XvuhuNYmdzjOXFqAsXXJ7ZeR0tr0xQhaR4qpp9+I79zHB4JVXDeOtUnrv/ni1DEn3m49tSMIml9+1SbDvUcui/xLYzcB7mOtvlwJJC6bBkcbOwJW8drH7WnSKYQVlUvO9PRg8+IWYABo4m/HoTrmg3JSd7+tfq1bmdsTjreC9G6uwJClVG1p8XyGEOijmNqXv9Ivunj8UzUvxVldTIg/taTAKdSlSG3i+xbnz28LKLpxSK2+M63p52Vf+hNJ0OycyVj1TkO+H8OQ==
X-YMail-OSG: BClZlNgVM1mJa1pSUAMlnjmDwJQUKDn0osVKNVIeZ6AC0JZQ8NzrV_.P2vPToBw
 lk4l1yMYy0P1wu9iKWHPF1vwWtED.NCcY6jE.jXdELnZdUngnDzcX.f1Ik7TcPjN._6dUftCNvSG
 0ilPDIIh6JKut3rld3EDzfXqVTEprJFL10dLfXEmdNXy8_9HzWnLN9Uxxh6FWr8nj4DbExyF48M8
 b8CzHn8AtWzh0fDjJqMRXb5UR1L1fHF.mq4wk_41bl8VHLLREhO8D9AiMB_Iou.TvP.xektI4Uzf
 lBotEg54S8nbe5a5a2eamKaLSiD6XaCIzSQkrGwkgk9qzk7J4361PG1C2lAWhSULJjGYH.uKi9SH
 8omXh8MvwuZmVU7umqXbA4eIFWV8ruRR3qRFWtA.2B0Eer.D49EbNovsAu.wRPm8yYyL6YMdaoys
 3vYAkjype1yPgR0gHAH3zObnNPMrtMzQfsTzcaha59dNYsVWPRo5EvcFgAIKXVIUqnKnooWuODru
 O4SgrdrM8PGEZGs5dJS.h.dJB3gwQ.0I1wf1Q_CLgJhbPMrumaMiWl3ifhN9G_CCxrGhRPRltqdB
 RyAvAXGENXKEJswzM.sYWHkLQyblOWaGX5TLKzeDGaJCZVu7CtZvQ0aNcyWtqrf4SAtE7MK9SqUH
 7phABBxeBrGdyDkvdUQOX_EPh25.Hb3SncDKllMEIHjvEdwbQcMGmqMEDVCI8Jh0nfgpjh259ODl
 q.bGW_sz63_QvjPWXygjUQ4RzfXiei1bHIkvbkPAHc04dS.Qr8LP1Jyxp2QD0wtNtJgo5RScK99X
 P5NPqcNAR8eez8YgXpk3cKLQCR9JSylhL6QyUVACODhQSLMO_l73eEDpWzNQUeEQLrEwA53TFUO9
 BXx4lR26gADp4OeWMANR3pTNDn8J7Oc5G1l.tF8AqVFtdsoB5vgCdw0tzoX9_22cJzNNteihaN9H
 ktOSXaCeUY26x9DWNkYi7HTOCc9F4vHnioRwelB9Lv.KGDeGPUJBBPmfcn0xXC8MB2YTlUFeVHzN
 FJsHhvFz9eJx.VwEAdhJs3DHW6xmbj9a_RSOf.BoLPiAvMAdoBe_1sVY8nFOqhuBwpkbj17TOzIW
 ts0JEWafkyantIFw8kEnIr0AHDEAK4aB1fgOVS8TQpbEaj2tB4pKHPa4OOjXszQAPBozr7PYVj2f
 6AcwHFYhcmsrFfliX20p43dgFMRY8GMXgvUWeegBAeAuOTxCoUC9WvAdL
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Jun 2019 16:28:49 +0000
Date:   Sat, 22 Jun 2019 16:28:46 +0000 (UTC)
From:   "Miss.Fatima Yusuf" <fatimayusuf5@outlook.fr>
Reply-To: miss.fmayusuf11@gmail.com
Message-ID: <270302503.296556.1561220926635@mail.yahoo.com>
Subject: From:Miss: Fatima Yusuf.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



From:Miss: Fatima Yusuf.

For sure this mail would definitely come to you as a surprise, but do take your good time to go through it, My name is Ms. Fatima Yusuf,i am from Ivory Coast.

I lost my parents a year and couple of months ago. My father was a serving director of the Agro-exporting board until his death. He was assassinated by his business partners.Before his death, he made a deposit of US$9.7 Million Dollars here in Cote d'ivoire which was for the purchase of cocoa processing machine and development of another factory before his untimely death.

Being that this part of the world experiences political and crises time without number, there is no guarantee of lives and properties. I cannot invest this money here any long, despite the fact it had been my late father's industrial plans.

I want you to do me a favor to receive this funds into your country or any safer place as the beneficiary, I have plans to invest this money in continuation with the investment vision of my late father, but not in this place again rather in your country. I have the vision of going into real estate and industrial production or any profitable business venture.

I will be ready to compensate you with 20% of the total Amount, now all my hope is banked on you and i really wants to invest this money in your country, where there is stability of Government, political and economic welfare.

My greatest worry now is how to move out of this country because my uncle is threatening to kill me as he killed my father,Please do not let anybody hear about this, it is between me and you alone because of my security reason.

I am waiting to hear from you.
Yours Sincerely,
Miss.Fatima Yusuf.
