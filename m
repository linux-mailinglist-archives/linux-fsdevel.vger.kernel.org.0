Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0373CB5D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhGPKTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:19:45 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:35269 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237766AbhGPKTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:19:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9C21A2B0140F;
        Fri, 16 Jul 2021 06:16:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 16 Jul 2021 06:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        YW2/suS+1HSGe/4jjcov1KPyTjR8DcjKuJHmptP47Wk=; b=PUBSloNZ/bCZzIYj
        OaaOssKJX7RHZlu8nzCUtMcFSWwwzIRUnaeQiJBYmSnqtGTqcMyaTme6oJ4toJ2L
        X18tlA132vtdCP7RXPSlZkrQ1eGs9fSlqkqg4jsS4u1jO/g+nrAA9cBZL4lrb8ER
        /Nw8QQed263fDvfyeusdhy1mZGZQaC7TlxbssEC6Fa0DTPTzewSnxhcjh5BXoEFF
        M/YoIXBNA2MNTsGSaTbCAHIsbkz08ZWpW8wYyG8LaFb9KF3VRJmmXOYeBkjJZ/Gw
        /0ZzEt1IOMWT3eFxayJe1sDBmQJayGnTOmcTQEmEiafnyWWXtEmfbCQ1MQluNW4L
        h0X3CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=YW2/suS+1HSGe/4jjcov1KPyTjR8DcjKuJHmptP47
        Wk=; b=Xk/lMmHb5XFw62X88YmJ4Kgf5Y53HcInsylAg0gXRIEm+m9iWSy0ertNf
        bJwH7zPuH97QM3M/2DxXHrDdsyg+2TS6kOVTffhE18dDDiX6GrZwAXNY3rIj3RP7
        0poOHQaF3gHMaX0ZCX1/6TUmRuiMiAKxd57wA3ARASOklSTnuHuaiBxaSgrK1qL/
        JC7qSsspXCSogxqsaQ44gtA/KFPHg9pNrgz+l+a2byO0+JGQ0asW35Lzo7/5dp19
        IevSaFRUcd7+/shHL7rtmUxNaxVWzN1pdjw7W0Awz7vYtGJlUWXuMbZgTLLXzdd0
        e61wdau0KazQnWxP+0WCMyIjPtE7Q==
X-ME-Sender: <xms:jlzxYESC1fmVCvwOKhPmokY42iFq6kBVwbn5qppJhsx2VYNOVdvV8g>
    <xme:jlzxYByrl4lOFQuRJo8piw7eq_T1_Qx2gC_RrT14QAS5AEDQyFSYGqPcFqrRIfF9C
    QZBzcUpYjks>
X-ME-Received: <xmr:jlzxYB1bf9ZJHwfOmnyhQzLVG_wnq6FBQQtuEjzOEVoAlRRdZNLcIW4Wu34a8r45Fg6hK6Lfxm6gxBs_g6UJsTpEvT9e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:jlzxYIBFtSkyaRkdiPqT8PY2344XlnVNGuoeOMiT1jUboZkF66dC4w>
    <xmx:jlzxYNhb4-ynM1tD1jPjmcVX9zmK3Jq1LsQ8meO-Sl_n97vUP9lHxg>
    <xmx:jlzxYErHWJ1KjZp-aYce3dj_KxpjaCZWNwKCJiW_IXoS-Lfg6eV8CA>
    <xmx:j1zxYIpAN_EcrqyKhK_-snAXraYzmF-zRkaB9rBItGVyoOkXruid-bMehTM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jul 2021 06:16:41 -0400 (EDT)
Message-ID: <a7386a9eba13176b4c6443b1677383a8121b9dc5.camel@themaw.net>
Subject: Re: [PATCH v8 0/5] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Jul 2021 18:16:38 +0800
In-Reply-To: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
References: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Here are benchmark test runs against patch set v8.
There pretty much the same a the v7 results as they should be.

1) Run with 40 distinct sysfs file paths on 80 cpu machine, perf graphs
in base-files-cpu-80-perf.txt and patched-files-cpu-80-perf.txt.

Base (5.12.3, unpatched)
------------------------
single: total 43.610095ms per 4.361009us
concur: total 4515.483148ms per 451.548315us  CPU 69
concur: total 4518.304581ms per 451.830458us  CPU 17
concur: total 4525.275675ms per 452.527567us  CPU 73
concur: total 4531.404107ms per 453.140411us  CPU 77
concur: total 4543.011580ms per 454.301158us  CPU 57
concur: total 4547.066040ms per 454.706604us  CPU 45
concur: total 4547.652917ms per 454.765292us  CPU 33
concur: total 4550.700660ms per 455.070066us  CPU 5
concur: total 4552.377974ms per 455.237797us  CPU 53
concur: total 4557.183667ms per 455.718367us  CPU 15
concur: total 4560.088854ms per 456.008885us  CPU 25
concur: total 4561.096541ms per 456.109654us  CPU 49
concur: total 4562.542284ms per 456.254228us  CPU 65
concur: total 4567.247924ms per 456.724792us  CPU 29
concur: total 4567.551375ms per 456.755137us  CPU 11
concur: total 4576.361518ms per 457.636152us  CPU 35
concur: total 4579.072483ms per 457.907248us  CPU 13
concur: total 4580.456910ms per 458.045691us  CPU 21
concur: total 4581.441238ms per 458.144124us  CPU 55
concur: total 4582.808775ms per 458.280878us  CPU 37
concur: total 4583.284351ms per 458.328435us  CPU 9
concur: total 4583.644571ms per 458.364457us  CPU 3
concur: total 4584.435959ms per 458.443596us  CPU 51
concur: total 4588.450469ms per 458.845047us  CPU 61
concur: total 4588.784765ms per 458.878476us  CPU 63
concur: total 4603.455415ms per 460.345542us  CPU 27
concur: total 4605.229148ms per 460.522915us  CPU 39
concur: total 4605.412438ms per 460.541244us  CPU 71
concur: total 4607.079973ms per 460.707997us  CPU 23
concur: total 4608.041174ms per 460.804117us  CPU 79
concur: total 4608.345038ms per 460.834504us  CPU 1
concur: total 4616.631547ms per 461.663155us  CPU 19
concur: total 4616.845962ms per 461.684596us  CPU 43
concur: total 4617.521385ms per 461.752139us  CPU 59
concur: total 4620.077938ms per 462.007794us  CPU 41
concur: total 4620.766014ms per 462.076601us  CPU 47
concur: total 4622.365869ms per 462.236587us  CPU 67
concur: total 4622.546362ms per 462.254636us  CPU 31
concur: total 4623.371457ms per 462.337146us  CPU 7
concur: total 4673.657084ms per 467.365708us  CPU 75
concur: total 4703.545988ms per 470.354599us  CPU 48
concur: total 4704.692544ms per 470.469254us  CPU 56
concur: total 4705.308174ms per 470.530817us  CPU 12
concur: total 4708.179087ms per 470.817909us  CPU 52
concur: total 4710.879479ms per 471.087948us  CPU 76
concur: total 4712.478473ms per 471.247847us  CPU 16
concur: total 4712.897185ms per 471.289718us  CPU 64
concur: total 4713.066302ms per 471.306630us  CPU 32
concur: total 4713.309041ms per 471.330904us  CPU 28
concur: total 4713.775133ms per 471.377513us  CPU 8
concur: total 4714.142315ms per 471.414232us  CPU 4
concur: total 4714.408679ms per 471.440868us  CPU 0
concur: total 4714.823031ms per 471.482303us  CPU 68
concur: total 4715.911133ms per 471.591113us  CPU 72
concur: total 4716.356891ms per 471.635689us  CPU 36
concur: total 4717.148390ms per 471.714839us  CPU 74
concur: total 4717.956787ms per 471.795679us  CPU 30
concur: total 4718.550180ms per 471.855018us  CPU 62
concur: total 4718.780680ms per 471.878068us  CPU 20
concur: total 4718.804903ms per 471.880490us  CPU 14
concur: total 4719.527173ms per 471.952717us  CPU 34
concur: total 4719.610769ms per 471.961077us  CPU 44
concur: total 4720.205242ms per 472.020524us  CPU 46
concur: total 4720.442429ms per 472.044243us  CPU 60
concur: total 4720.844723ms per 472.084472us  CPU 24
concur: total 4720.885926ms per 472.088593us  CPU 40
concur: total 4721.157172ms per 472.115717us  CPU 22
concur: total 4721.325226ms per 472.132523us  CPU 42
concur: total 4722.194975ms per 472.219497us  CPU 54
concur: total 4722.198238ms per 472.219824us  CPU 38
concur: total 4722.270686ms per 472.227069us  CPU 10
concur: total 4722.520311ms per 472.252031us  CPU 70
concur: total 4722.697182ms per 472.269718us  CPU 50
concur: total 4722.814473ms per 472.281447us  CPU 2
concur: total 4723.047319ms per 472.304732us  CPU 78
concur: total 4723.211099ms per 472.321110us  CPU 58
concur: total 4723.325139ms per 472.332514us  CPU 6
concur: total 4723.517066ms per 472.351707us  CPU 66
concur: total 4723.540041ms per 472.354004us  CPU 18
concur: total 4723.532642ms per 472.353264us  CPU 26
times: 10000 threads: 80 cpus: 80

patched (5.12.3)
----------------
single: total 42.800654ms per 4.280065us
concur: total 1497.315162ms per 149.731516us  CPU 40
concur: total 1523.384944ms per 152.338494us  CPU 6
concur: total 1527.974937ms per 152.797494us  CPU 41
concur: total 1528.611772ms per 152.861177us  CPU 4
concur: total 1530.640917ms per 153.064092us  CPU 2
concur: total 1531.255960ms per 153.125596us  CPU 28
concur: total 1531.502709ms per 153.150271us  CPU 22
concur: total 1531.550394ms per 153.155039us  CPU 54
concur: total 1531.951529ms per 153.195153us  CPU 60
concur: total 1532.197299ms per 153.219730us  CPU 78
concur: total 1532.279187ms per 153.227919us  CPU 48
concur: total 1533.034026ms per 153.303403us  CPU 14
concur: total 1533.558031ms per 153.355803us  CPU 32
concur: total 1534.782403ms per 153.478240us  CPU 62
concur: total 1534.997189ms per 153.499719us  CPU 56
concur: total 1536.109295ms per 153.610929us  CPU 38
concur: total 1536.214181ms per 153.621418us  CPU 18
concur: total 1537.096808ms per 153.709681us  CPU 36
concur: total 1537.612459ms per 153.761246us  CPU 42
concur: total 1538.681882ms per 153.868188us  CPU 12
concur: total 1538.912144ms per 153.891214us  CPU 20
concur: total 1539.133370ms per 153.913337us  CPU 76
concur: total 1539.732430ms per 153.973243us  CPU 8
concur: total 1540.007044ms per 154.000704us  CPU 66
concur: total 1540.497045ms per 154.049704us  CPU 44
concur: total 1540.982660ms per 154.098266us  CPU 16
concur: total 1541.037031ms per 154.103703us  CPU 26
concur: total 1541.441290ms per 154.144129us  CPU 72
concur: total 1541.445028ms per 154.144503us  CPU 34
concur: total 1541.899099ms per 154.189910us  CPU 46
concur: total 1542.395210ms per 154.239521us  CPU 74
concur: total 1542.641833ms per 154.264183us  CPU 58
concur: total 1543.768222ms per 154.376822us  CPU 1
concur: total 1543.781564ms per 154.378156us  CPU 10
concur: total 1545.325536ms per 154.532554us  CPU 64
concur: total 1545.602875ms per 154.560287us  CPU 70
concur: total 1545.628720ms per 154.562872us  CPU 30
concur: total 1547.650530ms per 154.765053us  CPU 68
concur: total 1547.925833ms per 154.792583us  CPU 52
concur: total 1550.700993ms per 155.070099us  CPU 24
concur: total 1551.551400ms per 155.155140us  CPU 55
concur: total 1552.062602ms per 155.206260us  CPU 49
concur: total 1552.084444ms per 155.208444us  CPU 33
concur: total 1552.080191ms per 155.208019us  CPU 7
concur: total 1552.108824ms per 155.210882us  CPU 35
concur: total 1552.169043ms per 155.216904us  CPU 50
concur: total 1552.246985ms per 155.224699us  CPU 17
concur: total 1552.266063ms per 155.226606us  CPU 21
concur: total 1552.322319ms per 155.232232us  CPU 23
concur: total 1552.921723ms per 155.292172us  CPU 3
concur: total 1553.085462ms per 155.308546us  CPU 45
concur: total 1553.360574ms per 155.336057us  CPU 37
concur: total 1553.736812ms per 155.373681us  CPU 69
concur: total 1553.810163ms per 155.381016us  CPU 63
concur: total 1554.245252ms per 155.424525us  CPU 75
concur: total 1554.587717ms per 155.458772us  CPU 47
concur: total 1554.811591ms per 155.481159us  CPU 9
concur: total 1555.156676ms per 155.515668us  CPU 5
concur: total 1555.240540ms per 155.524054us  CPU 27
concur: total 1555.270924ms per 155.527092us  CPU 79
concur: total 1555.502580ms per 155.550258us  CPU 57
concur: total 1555.650301ms per 155.565030us  CPU 43
concur: total 1555.684979ms per 155.568498us  CPU 77
concur: total 1555.784989ms per 155.578499us  CPU 67
concur: total 1555.892789ms per 155.589279us  CPU 15
concur: total 1555.894896ms per 155.589490us  CPU 73
concur: total 1556.029098ms per 155.602910us  CPU 29
concur: total 1556.136688ms per 155.613669us  CPU 59
concur: total 1556.184156ms per 155.618416us  CPU 61
concur: total 1556.272459ms per 155.627246us  CPU 19
concur: total 1556.316365ms per 155.631637us  CPU 39
concur: total 1556.448166ms per 155.644817us  CPU 31
concur: total 1556.494722ms per 155.649472us  CPU 25
concur: total 1556.874991ms per 155.687499us  CPU 13
concur: total 1556.964956ms per 155.696496us  CPU 65
concur: total 1557.505884ms per 155.750588us  CPU 53
concur: total 1557.670220ms per 155.767022us  CPU 71
concur: total 1558.641962ms per 155.864196us  CPU 0
concur: total 1559.141537ms per 155.914154us  CPU 51
concur: total 1559.180879ms per 155.918088us  CPU 11
times: 10000 threads: 80 cpus: 80

2) Run with a single sysfs file path on 80 cpu machine, perf graphs in
base-missing-cpu-80-perf.txt and patched-missing-cpu-80-perf.txt.

Base (5.12.3, unpatched)
------------------------
single: total 24.746542ms per 2.474654us
concur: total 11642.525326ms per 1164.252533us  CPU 41
concur: total 11753.266354ms per 1175.326635us  CPU 21
concur: total 11882.784250ms per 1188.278425us  CPU 5
concur: total 11897.657687ms per 1189.765769us  CPU 13
concur: total 11915.176939ms per 1191.517694us  CPU 61
concur: total 12032.739153ms per 1203.273915us  CPU 45
concur: total 12095.349631ms per 1209.534963us  CPU 33
concur: total 12147.225465ms per 1214.722546us  CPU 65
concur: total 12236.584495ms per 1223.658449us  CPU 73
concur: total 12273.499836ms per 1227.349984us  CPU 25
concur: total 12327.559782ms per 1232.755978us  CPU 1
concur: total 12339.221934ms per 1233.922193us  CPU 53
concur: total 12592.935435ms per 1259.293543us  CPU 69
concur: total 12751.932850ms per 1275.193285us  CPU 57
concur: total 12789.601281ms per 1278.960128us  CPU 49
concur: total 12800.329994ms per 1280.032999us  CPU 15
concur: total 12899.047414ms per 1289.904741us  CPU 29
concur: total 12950.772402ms per 1295.077240us  CPU 55
concur: total 13031.263191ms per 1303.126319us  CPU 17
concur: total 13077.573490ms per 1307.757349us  CPU 59
concur: total 13086.450703ms per 1308.645070us  CPU 19
concur: total 13112.144105ms per 1311.214410us  CPU 47
concur: total 13167.152306ms per 1316.715231us  CPU 32
concur: total 13203.910956ms per 1320.391096us  CPU 9
concur: total 13230.538364ms per 1323.053836us  CPU 60
concur: total 13232.286187ms per 1323.228619us  CPU 23
concur: total 13244.948925ms per 1324.494893us  CPU 75
concur: total 13260.586625ms per 1326.058663us  CPU 24
concur: total 13279.711923ms per 1327.971192us  CPU 4
concur: total 13290.308549ms per 1329.030855us  CPU 64
concur: total 13297.234721ms per 1329.723472us  CPU 37
concur: total 13297.585100ms per 1329.758510us  CPU 7
concur: total 13300.929348ms per 1330.092935us  CPU 20
concur: total 13311.528772ms per 1331.152877us  CPU 46
concur: total 13315.521790ms per 1331.552179us  CPU 52
concur: total 13331.269808ms per 1333.126981us  CPU 28
concur: total 13333.563808ms per 1333.356381us  CPU 26
concur: total 13334.923225ms per 1333.492323us  CPU 39
concur: total 13340.811453ms per 1334.081145us  CPU 72
concur: total 13346.192625ms per 1334.619263us  CPU 63
concur: total 13349.415339ms per 1334.941534us  CPU 68
concur: total 13352.414423ms per 1335.241442us  CPU 0
concur: total 13354.401586ms per 1335.440159us  CPU 44
concur: total 13356.828605ms per 1335.682861us  CPU 54
concur: total 13358.754397ms per 1335.875440us  CPU 16
concur: total 13362.014261ms per 1336.201426us  CPU 12
concur: total 13364.189431ms per 1336.418943us  CPU 6
concur: total 13364.252331ms per 1336.425233us  CPU 67
concur: total 13365.159491ms per 1336.515949us  CPU 76
concur: total 13369.198367ms per 1336.919837us  CPU 48
concur: total 13369.574959ms per 1336.957496us  CPU 36
concur: total 13377.299530ms per 1337.729953us  CPU 40
concur: total 13377.717747ms per 1337.771775us  CPU 35
concur: total 13377.886941ms per 1337.788694us  CPU 56
concur: total 13382.748789ms per 1338.274879us  CPU 66
concur: total 13384.125526ms per 1338.412553us  CPU 79
concur: total 13384.216216ms per 1338.421622us  CPU 58
concur: total 13388.371680ms per 1338.837168us  CPU 18
concur: total 13393.289323ms per 1339.328932us  CPU 10
concur: total 13394.423134ms per 1339.442313us  CPU 8
concur: total 13394.537986ms per 1339.453799us  CPU 14
concur: total 13396.152597ms per 1339.615260us  CPU 30
concur: total 13397.312727ms per 1339.731273us  CPU 34
concur: total 13397.555389ms per 1339.755539us  CPU 70
concur: total 13398.055759ms per 1339.805576us  CPU 78
concur: total 13399.219289ms per 1339.921929us  CPU 77
concur: total 13401.160948ms per 1340.116095us  CPU 38
concur: total 13401.177905ms per 1340.117790us  CPU 27
concur: total 13401.652556ms per 1340.165256us  CPU 50
concur: total 13403.311058ms per 1340.331106us  CPU 22
concur: total 13406.279259ms per 1340.627926us  CPU 42
concur: total 13406.714708ms per 1340.671471us  CPU 2
concur: total 13409.186649ms per 1340.918665us  CPU 74
concur: total 13409.591594ms per 1340.959159us  CPU 62
concur: total 13410.246135ms per 1341.024613us  CPU 31
concur: total 13412.007054ms per 1341.200705us  CPU 11
concur: total 13412.140675ms per 1341.214068us  CPU 71
concur: total 13412.737053ms per 1341.273705us  CPU 51
concur: total 13413.214418ms per 1341.321442us  CPU 3
concur: total 13414.303830ms per 1341.430383us  CPU 43
times: 10000 threads: 80 cpus: 80

patched (5.12.3)
----------------
single: total 23.208077ms per 2.320808us
concur: total 1206.802099ms per 120.680210us  CPU 22
concur: total 1208.930779ms per 120.893078us  CPU 8
concur: total 1211.247205ms per 121.124721us  CPU 34
concur: total 1212.998353ms per 121.299835us  CPU 62
concur: total 1213.389780ms per 121.338978us  CPU 28
concur: total 1215.414555ms per 121.541455us  CPU 48
concur: total 1218.962627ms per 121.896263us  CPU 36
concur: total 1219.112096ms per 121.911210us  CPU 74
concur: total 1219.292732ms per 121.929273us  CPU 68
concur: total 1219.454262ms per 121.945426us  CPU 2
concur: total 1219.937964ms per 121.993796us  CPU 20
concur: total 1221.773152ms per 122.177315us  CPU 42
concur: total 1222.383925ms per 122.238393us  CPU 16
concur: total 1222.753728ms per 122.275373us  CPU 14
concur: total 1222.824826ms per 122.282483us  CPU 0
concur: total 1224.441811ms per 122.444181us  CPU 56
concur: total 1224.779489ms per 122.477949us  CPU 6
concur: total 1224.973746ms per 122.497375us  CPU 40
concur: total 1225.042053ms per 122.504205us  CPU 54
concur: total 1225.513107ms per 122.551311us  CPU 4
concur: total 1225.848993ms per 122.584899us  CPU 76
concur: total 1226.191945ms per 122.619195us  CPU 32
concur: total 1226.556633ms per 122.655663us  CPU 38
concur: total 1226.642992ms per 122.664299us  CPU 60
concur: total 1227.444816ms per 122.744482us  CPU 46
concur: total 1227.981028ms per 122.798103us  CPU 18
concur: total 1228.193518ms per 122.819352us  CPU 44
concur: total 1228.550486ms per 122.855049us  CPU 26
concur: total 1228.840427ms per 122.884043us  CPU 24
concur: total 1229.017209ms per 122.901721us  CPU 78
concur: total 1229.724519ms per 122.972452us  CPU 72
concur: total 1229.878627ms per 122.987863us  CPU 12
concur: total 1230.770167ms per 123.077017us  CPU 66
concur: total 1231.876743ms per 123.187674us  CPU 58
concur: total 1232.688921ms per 123.268892us  CPU 64
concur: total 1233.311151ms per 123.331115us  CPU 52
concur: total 1236.349393ms per 123.634939us  CPU 30
concur: total 1240.084640ms per 124.008464us  CPU 70
concur: total 1247.767398ms per 124.776740us  CPU 10
concur: total 1248.471436ms per 124.847144us  CPU 50
concur: total 1249.292940ms per 124.929294us  CPU 39
concur: total 1295.617635ms per 129.561764us  CPU 23
concur: total 1297.170489ms per 129.717049us  CPU 9
concur: total 1297.964528ms per 129.796453us  CPU 63
concur: total 1299.431947ms per 129.943195us  CPU 35
concur: total 1299.701030ms per 129.970103us  CPU 49
concur: total 1299.703983ms per 129.970398us  CPU 29
concur: total 1300.535158ms per 130.053516us  CPU 3
concur: total 1300.902632ms per 130.090263us  CPU 1
concur: total 1301.034574ms per 130.103457us  CPU 5
concur: total 1301.105484ms per 130.110548us  CPU 17
concur: total 1301.141575ms per 130.114158us  CPU 75
concur: total 1301.499277ms per 130.149928us  CPU 69
concur: total 1301.970890ms per 130.197089us  CPU 41
concur: total 1302.582629ms per 130.258263us  CPU 57
concur: total 1302.751012ms per 130.275101us  CPU 43
concur: total 1302.816857ms per 130.281686us  CPU 45
concur: total 1302.909810ms per 130.290981us  CPU 15
concur: total 1303.018114ms per 130.301811us  CPU 21
concur: total 1303.023366ms per 130.302337us  CPU 7
concur: total 1303.218080ms per 130.321808us  CPU 37
concur: total 1303.578443ms per 130.357844us  CPU 27
concur: total 1303.954501ms per 130.395450us  CPU 47
concur: total 1304.038096ms per 130.403810us  CPU 55
concur: total 1304.040952ms per 130.404095us  CPU 33
concur: total 1304.156534ms per 130.415653us  CPU 77
concur: total 1304.188698ms per 130.418870us  CPU 19
concur: total 1304.792850ms per 130.479285us  CPU 67
concur: total 1304.894882ms per 130.489488us  CPU 25
concur: total 1304.996763ms per 130.499676us  CPU 61
concur: total 1305.107675ms per 130.510768us  CPU 13
concur: total 1305.370941ms per 130.537094us  CPU 73
concur: total 1305.487118ms per 130.548712us  CPU 59
concur: total 1305.654535ms per 130.565453us  CPU 65
concur: total 1305.891900ms per 130.589190us  CPU 53
concur: total 1306.513791ms per 130.651379us  CPU 31
concur: total 1307.221019ms per 130.722102us  CPU 71
concur: total 1309.522870ms per 130.952287us  CPU 11
concur: total 1309.526910ms per 130.952691us  CPU 51
concur: total 1316.416007ms per 131.641601us  CPU 79
times: 10000 threads: 80 cpus: 80

Ian

