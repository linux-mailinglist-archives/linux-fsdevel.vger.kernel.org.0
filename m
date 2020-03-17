Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2651718831A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 13:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCQMJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 08:09:45 -0400
Received: from sonic308-2.consmr.mail.ne1.yahoo.com ([66.163.187.121]:38003
        "EHLO sonic308-2.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbgCQMJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584446983; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Y5EVuw/rLgZWRMyXdYT50zJetJc6qxTaFtkDUd61yC67972Pv8BafoOYY5PpfFzHkhB66Bg4rtcMSXoq8A7BL5IIgjK9SJC8mxZMQRlRszKv6bj9MOQPdyR95GfO4fmEMbXi94ih/l1RXHAKAecbkLgb7E2jzk98FO+oKrElObmAlhaNIBdqAwP4X5M/wIs5btVaU9rpX2/LYk0A5ti2YrPZfCG30sXdz3iJZlGWvqkRf/8ofp7KEmaugfrBD9+fheWe5dd8wMA0fEsTW3+x/Z0bOHPIrt9VT3GhnXsUoqgqwXBjD6HuTC7XSQAlw6k4FMj1kCDmySakb8tto9ElPw==
X-YMail-OSG: G42Kh.gVM1knbTm_ea7wDoC40E6mWcHxSA9L_Bt_wnpBVmL882rMq9bJ2rg9qeQ
 hGJsKP6ixdHr58L4tqUtrrFYe4Ow4blICkwYwQX_Ue4k_yt6aioGE8t4rs2GJ09La4RlaQeUVAP5
 I1B1JU8Bxt1YqGQu8ncZ.Xd6id0PE4.SYHek8aBYxFevAgCoWKBWgIhrsG7iVN_ZshTI_sI1UOl8
 S.HbmHQFVHj7iYn9OiFSZfkbtsmJ80KcIxr.5wpySaW5p09F_pPeb5LdneUAKtwPvavTm1o_9O18
 isTXNqESksVG_I_Zn8QONuM7sPvR.nvbJgUv_0wykTVYMOOAPG1pRXNI5bmFKc2ouhHWS85iNubW
 qzLmd8XGPCS1K.D6Cm.8LNtrbQLw6N_6d2LLN7Mn0kJQuMiUc6bm2zZG8_mUpU6Enw.JqWMPbxn1
 _kx5M8vf8Ujp9B3sbTuXIxYiieWVRHXtf.cudBqDMsrNFMxouW4hvbOZkUaP9tlQbDxSq8BS01mH
 dGH7EPFC071LXSNqiG3msjeprMWww1FIEdtvxguemtkFWwqNBkhi6mynLkUJ3tXL7eos3VVBC5GC
 2T.gNA2mB3d5JOWMyRf5vKOGieqwKRURZJrYFdXZfLgBIi.ctJPp8PTNZWbVJZPvFLspXzbiYOAM
 _tjWurYsHFh.nj4awKT22f7RY6I2QetZp_gEug.5EG0eF05mw6ALEmZkyGEbYDwAWHIV_HrUkk4Q
 7x0FYgxRLUV7A7Pf9.j.Qv8eCr3WOfcH6fzugui36LKhqED0SiEJHpkDtre.e9ZMd90ikBoDt9FV
 B8j35JQHGGO5vYLnQXpPleh3MsSF7ELpoT_j_6IWp.wX.yUiwMa4ajOOmQhWItdMC0BPjiLrYMay
 YFE.jtyXFSXWlJHCNNo84.nVn25Ek5Y1AZ9xnRFVUUhqwa0BWgSENaDaql4kxOeQx9L8OdOCmFU6
 FZjaFneQdZDPnY_zzvHSWcM3OAvmc7ZM0iaVkqk.GQrka8Twl1K91Us9UJ0frPlmKBcEMLKCg2t2
 2OArVmvWH9WkilexAh2vN09fZtIZHEDSNe5mJNyK4gr6CDjUyxCGKWLXYOn4Xr09h0q75kY8B6U_
 BH75yA0JaBM80xTEJU2l8j9lFLEQA6TOIRHuG5weoYFzlsA6AqHUnYpnLdFw8FsRq1Jt4RP0rXfC
 iMpWfmp1bpcFbGJtrrD7.7T2.yzzZmwPeGg4eL5YmF.wfuAAu9L.8uYv_8B3.WCWSQZRc.m_lK_g
 3sOnlkGM78WG5tUzqKtrD2IGaT1bFCAMoLFQh3vemnklC4pBz7_MMntFoMmjjSpxlS1bTG3a_Kxs
 6nu1WXFPK4e0mTIR8w1L1eRXn5lg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:09:43 +0000
Date:   Tue, 17 Mar 2020 12:07:42 +0000 (UTC)
From:   Stephen Li <stenn7@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <608201144.1808131.1584446862432@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <608201144.1808131.1584446862432.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
