Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98E619FDDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 21:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDFTJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 15:09:48 -0400
Received: from fallback14.mail.ru ([94.100.179.44]:51982 "EHLO
        fallback14.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDFTJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From; bh=IuqH8oOZ7Smuf50iB0pt180lv+WFKGM8y/rdC+IqHuI=;
        b=o05WS8wLMnY48IpjiVA8q1yyulzCH6WsGIYZwxSQKGopLT5RuV5J3DyQj7kbGiSRtfW7kjOkrVtmTxbjAKUdKQp3T5x4hrXeb5pVszcdufWse4319aLsF4zPX/eIpVUfV92aNjydD7ZoJzkybQvXOUUea1tRVHF18fbtd7LjMKM=;
Received: from [10.161.63.35] (port=55450 helo=f412.i.mail.ru)
        by fallback14.m.smailru.net with esmtp (envelope-from <safinaskar@mail.ru>)
        id 1jLX7w-0004qe-2c; Mon, 06 Apr 2020 22:09:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From; bh=IuqH8oOZ7Smuf50iB0pt180lv+WFKGM8y/rdC+IqHuI=;
        b=o05WS8wLMnY48IpjiVA8q1yyulzCH6WsGIYZwxSQKGopLT5RuV5J3DyQj7kbGiSRtfW7kjOkrVtmTxbjAKUdKQp3T5x4hrXeb5pVszcdufWse4319aLsF4zPX/eIpVUfV92aNjydD7ZoJzkybQvXOUUea1tRVHF18fbtd7LjMKM=;
Received: by f412.i.mail.ru with local (envelope-from <safinaskar@mail.ru>)
        id 1jLX7t-0000Hb-Eq; Mon, 06 Apr 2020 22:09:41 +0300
Received: by light.mail.ru with HTTP;
        Mon, 06 Apr 2020 22:09:41 +0300
From:   =?UTF-8?B?QXNrYXIgU2FmaW4=?= <safinaskar@mail.ru>
To:     asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: =?UTF-8?B?UmU6IFtQT0MgUkZDIDAvM10gc3BsaWNlKDIpIHN1cHBvcnQgZm9yIGlvX3Vy?=
 =?UTF-8?B?aW5n?=
MIME-Version: 1.0
X-Mailer: Mail.Ru Mailer 1.0
Date:   Mon, 06 Apr 2020 22:09:41 +0300
Reply-To: =?UTF-8?B?QXNrYXIgU2FmaW4=?= <safinaskar@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <1586200181.435329676@f412.i.mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-7564579A: 646B95376F6C166E
X-77F55803: 0A44E481635329DB4E7FAE048FD183FFD32E5E488652173699CE90E9CBBFB45FD85348D1E2A9D7ADFBDBF69DD7E3F5385EBDC71A3AD865557E0E8ECF5F1B131EA9B517628670D6AC19BBA5EB247851AA
X-7FA49CB5: 70AAF3C13DB7016878DA827A17800CE75EE3C8C1E9563377D82A6BABE6F325AC9EB98D58427B1C2A7C6FB206A91F05B29C7C0829E2D134F6D7B4160BD3A4204CFEEB761FB9071033D2E47CDBA5A96583C09775C1D3CA48CFCA5A41EBD8A3A0199FA2833FD35BB23D2EF20D2F80756B5F40A5AABA2AD37119CC7F00164DA146DA9985D098DBDEAEC8EDCF5861DED71B2F389733CBF5DBD5E9B5C8C57E37DE458B4C7702A67D5C33162DBA43225CD8A89F0A35B161A8BF67C135872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi098oNK9gy3Irm5KFwLuDg60je4lC+GbTj0M8KbzpOmgsB7wYP6nnel8wfEHQiZAetlEg7qy07ISeqrIhHPnkjzMJIKhkt3sDQ==
X-Mailru-Internal-Actual: A:0.86392021091368
X-Mailru-Sender: 5EEECD413B34D8D993653919C5945805FE1BF4CAD608F7818366DED19131207113EE28446F3ACD7AE050B273745CFBD67903AA853BEC14D66BF3EC0C2B8D44F11752C749FAB18CA3A8F61D99D8C7FF8FA4CD9F439FE7F8175FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Spam: undefined
X-7564579A: EEAE043A70213CC8
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDC345666C2E9EB2C0D55E1275D1DAB18D9BA01449C46688777952C6472C343E45A
X-7FA49CB5: 0D63561A33F958A59B2DE3E227FDBE6E3D0F53EE919DFB671E576249E52586428941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E735156CCFE7AF13BCA4B5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DBEB6346B700B4D54FE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi098oNK9gy3Irm5KFwLuDg60je4lC+GbTj0M8KbzpOmgsB7wYP6nnel8wfEHQiZAetlEg7qy07ISeqrIhHPnkjzNy7BgrLUYXw==
X-Mailru-MI: 800
X-Mras: Ok
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkuIFRoYW5rcyBmb3IgeW91ciBzcGxpY2UgaW9fdXJpbmcgcGF0Y2guIE1heWJlIGl0IHdpbGwg
YmUgZ29vZCBpZGVhIHRvIGFkZCB1cmluZyBvcGVyYXRpb24sIHdoaWNoIHdpbGwgdW5pZnkgc3Bs
aWNlLCBzZW5kZmlsZSBhbmQgY29weV9maWxlX3JhbmdlIGluc3RlYWQgb2YganVzdCBJT1JJTkdf
T1BfU1BMSUNFPwo9PQpBc2thciBTYWZpbgpodHRwczovL2dpdGh1Yi5jb20vc2FmaW5hc2thcgo=
